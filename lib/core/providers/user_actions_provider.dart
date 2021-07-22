import 'package:cutso/core/providers/paytm_provider.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:nanoid/async.dart';

import '../../features/cart/data/models/order.dart';
import '../../features/login/data/models/user.dart';
import '../../features/login/presentation/provider/address_form_provider.dart';
import '../../features/login/presentation/provider/registration_form_provider.dart';
import '../../features/profile/data/sources/orders_repository.dart';
import '../../main_common.dart';
import '../error/failures.dart';
import 'firebase_provider.dart';
import 'shared_preferences_provider.dart';

final userActionsProvider = ChangeNotifierProvider((ref) => UserNotifier());

class UserNotifier extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    if (user != null) {
      if (cart.orderItems.isNotEmpty) {
        cart = _cart;
      } else {
        cart = user.cart;
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
      cart = Cart(orderItems: []);
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

  Cart _cart = Cart(orderItems: []);
  Cart get cart => _cart;
  set cart(Cart cart) {
    _cart = cart;
    if (user != null) {
      updateCart(cart).then(
        (value) {
          if (value.isLeft()) {
            container
                .read(crashlyticsProvider)
                .log("Cart could not be updated to Firestore");
          }
        },
      );
    }
    notifyListeners();
  }

  Future<dz.Either<ServerFailure, void>> updateCart(Cart cart) async {
    try {
      await container
          .read(usersProvider)
          .doc(_user!.uid)
          .update({'cart': cart.toJson()});
      return const dz.Right(null);
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      Logger.root.severe('Unable to update the cart', exception, stack);
      return dz.Left(ServerFailure(exception.toString()));
    }
  }

  Future<dz.Either<ServerFailure, void>> placeOrder(Cart cart) async {
    // TODO: Setup cloud functions for iOS
    try {
      final order = Order(
        uid: _user!.uid,
        orderId: await nanoid(12),
        orderItems: cart,
        value: getCartValue(),
        coupon: null,
        status: Status.paymentPending,
      );

      final dz.Either<ServerFailure, void> paymentRunner =
          await container.read(paytmProvider).initiatePayment(order);
      paymentRunner.fold(
        (failure) => debugPrint("Payment failed!"),
        (success) => debugPrint("Payment was successful!"),
      );
      

      container.read(orderRepositoryProvider).pushOrder(order);
      _user!.orders.add(order.orderId);
      await container
          .read(usersProvider)
          .doc(user!.uid)
          .update({'orders': user!.orders.toJson()});
      updateCart(Cart(orderItems: []));
      return const dz.Right(null);
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      Logger.root.severe('Unable to update the cart', exception, stack);
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
    for (final orderItem in cart.orderItems) {
      _value += orderItem.price;
    }
    return _value;
  }
}
