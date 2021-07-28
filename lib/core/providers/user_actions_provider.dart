import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';

import '../../features/cart/data/models/order.dart';
import '../../features/login/data/models/user.dart';
import '../../features/login/presentation/provider/address_form_provider.dart';
import '../../features/login/presentation/provider/registration_form_provider.dart';
import '../../features/profile/data/sources/orders_repository.dart';
import '../../main_common.dart';
import '../error/failures.dart';
import 'firebase_provider.dart';
import 'paytm_provider.dart';
import 'shared_preferences_provider.dart';

final userActionsProvider = ChangeNotifierProvider((ref) => UserNotifier());

// enum OrderStatus {
//   paymentRequested,
//   paymentProcessing,
//   paymentSuccessful,
//   paymentDeclined,
// }

class UserNotifier extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    if (user != null) {
      if (user.cart.isNotEmpty) {
        cart = user.cart;
      } else {
        cart = _cart;
      }
      container
          .read(sharedPreferencesProvider)
          .then((prefs) => prefs.setString("uid", user.uid));
      container.read(usersProvider).doc(user.uid).update(user.toJson());
      container.read(registrationFormProvider).name = user.fullName;
      container.read(registrationFormProvider).email = user.email;
      container.read(registrationFormProvider).mobileNo = user.phone;
      container.read(addressFormProvider).name = user.address.name;
      container.read(addressFormProvider).line = user.address.line;
      container.read(addressFormProvider).landmark = user.address.landmark;
    } else {
      // ! when the user is signed out
      cart = [];
      container.read(sharedPreferencesProvider).then((prefs) => prefs.clear());
      container.read(registrationFormProvider).name = null;
      container.read(registrationFormProvider).email = null;
      container.read(registrationFormProvider).mobileNo = null;
      container.read(addressFormProvider).name = null;
      container.read(addressFormProvider).line = null;
      container.read(addressFormProvider).landmark = null;
    }
    notifyListeners();
  }

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  set cart(List<CartItem> cart) {
    _cart = cart;
    if (user != null) {
      updateCart(cart).then(
        (value) {
          if (value.isRight()) {
            container
                .read(loggerProvider)
                .i("Cart was successfully updated to Firestore");
          }
        },
      );
    }
    notifyListeners();
  }

  Future<dz.Either<ServerFailure, void>> updateCart(List<CartItem> cart) async {
    try {
      final List<Map<String, dynamic>> cartJson =
          cart.map((e) => e.toJson()).toList();
      await container
          .read(usersProvider)
          .doc(_user!.uid)
          .update({'cart': cartJson});
      return const dz.Right(null);
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      container
          .read(loggerProvider)
          .e('Unable to update the cart', exception, stack);
      return dz.Left(ServerFailure(exception.toString()));
    }
  }

  Future<dz.Either<ServerFailure, bool>> placeOrder() async {
    // TODO: Setup cloud functions for iOS
    try {
      final order = Order(
        uid: _user!.uid,
        orderId: await nanoid(12),
        items: cart,
        value: getCartValue(),
        coupon: null,
        status: Status.paymentPending,
      );

      bool orderPlaced = false;

      final dz.Either<ServerFailure, void> paymentRunner =
          await container.read(paytmProvider).initiatePayment(order);
      paymentRunner.fold(
        (failure) => container.read(loggerProvider).i("Payment failed!"),
        (success) async {
          orderPlaced = true;
          container.read(loggerProvider).i("Payment was successful!");
          container.read(orderRepositoryProvider).pushOrder(order);
          _user!.orders.add(order.orderId);
          await container
              .read(usersProvider)
              .doc(user!.uid)
              .update({'orders': user!.orders});
          _cart = [];
        },
      );

      // TODO: If payment is successful set up delivery

      return dz.Right(orderPlaced);
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      container.read(loggerProvider).e(exception);
      return dz.Left(ServerFailure());
    }
  }

  Future<dz.Either<Failure, void>> updateAddress(Address address) async {
    try {
      if (_user != null) {
        user = _user!.copyWith(address: address);
        return const dz.Right(null);
      }
      container.read(crashlyticsProvider).log("Cannot update empty user");
      return dz.Left(ServerFailure("Cannot update empty user"));
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return dz.Left(AuthFailure(error.toString()));
    }
  }

  Future<dz.Either<Failure, void>> updateDetails(
      String name, String email, String mobileNo) async {
    try {
      if (_user != null) {
        user = _user!.copyWith(fullName: name, email: email, phone: mobileNo);
        return const dz.Right(null);
      }
      container.read(crashlyticsProvider).log("Cannot update empty user");
      return dz.Left(ServerFailure("Cannot update empty user"));
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return dz.Left(AuthFailure(error.toString()));
    }
  }

  double getCartValue() {
    double _value = 0.0;
    for (final CartItem item in cart) {
      _value += item.price;
    }
    return _value;
  }
}
