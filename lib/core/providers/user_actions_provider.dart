import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';

import '../../features/cart/data/models/order.dart';
import '../../features/login/data/models/user.dart';
import '../../features/login/presentation/provider/address_form_provider.dart';
import '../../features/login/presentation/provider/registration_form_provider.dart';
import '../../features/profile/data/sources/orders_repository.dart';
import '../../main.dart';
import '../error/failures.dart';
import 'firebase_provider.dart';

final userActionsProvider = ChangeNotifierProvider((ref) => UserNotifier());

class UserNotifier extends ChangeNotifier {
  User? _user;
  Cart _cart = Cart(orderItems: []);

  User? get user => _user;
  Cart get cart => _cart;

  set user(User? user) {
    _user = user;
    if (user != null) {
      _cart = user.cart;
      container.read(registrationFormProvider).setName(user.fullName);
      container.read(registrationFormProvider).setEmail(user.email);
      container.read(registrationFormProvider).setMobileNo(user.phone);
      container.read(addressFormProvider).setAddressName(user.address.name);
      container.read(addressFormProvider).setAddressLine(user.address.line);
      container
          .read(addressFormProvider)
          .setAddressLandmark(user.address.landmark);
    }
    notifyListeners();
  }

  set cart(Cart cart) {
    _cart = cart;
    updateCart(cart).then(
      (value) {
        if (value.isLeft()) {
          container
              .read(crashlyticsProvider)
              .log("Cart could not be updated to Firestore");
        }
      },
    );
    notifyListeners();
  }

  Future<dz.Either<ServerFailure, void>> updateCart(Cart cart) async {
    try {
      _cart = cart;
      await container
          .read(usersProvider)
          .doc(_user!.uid)
          .update({'cart': cart.toJson()});
      return const dz.Right(null);
    } on Exception {
      return dz.Left(ServerFailure());
    }
  }

  Future<dz.Either<ServerFailure, void>> placeOrder(Cart cart) async {
    try {
      final order = Order(
        uid: _user!.uid,
        orderId: await nanoid(10),
        orderItems: cart,
        value: getCartValue(cart),
        coupon: null,
        status: Status.paymentPending,
      );
      container.read(orderRepositoryProvider).pushOrder(order);
      return const dz.Right(null);
    } on Exception {
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
}

double getCartValue(Cart cart) {
  double _value = 0.0;
  for (final orderItem in cart.orderItems) {
    _value += orderItem.price;
  }
  return _value;
}
