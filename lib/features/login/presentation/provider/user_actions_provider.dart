import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../main.dart';
import '../../../cart/data/models/order.dart';
import '../../../cart/data/sources/orders_repository.dart';
import '../../data/models/cart.dart';
import '../../data/models/user.dart';
import 'mobile_form_provider.dart';

final userActionsProvider = ChangeNotifierProvider((ref) => UserNotifier());

class UserNotifier extends ChangeNotifier {
  User? _user;
  Cart _cart = Cart.empty();

  User? get user => _user;
  Cart get cart => _cart;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> setCart(Cart cart) async {
    _cart = cart;
    await updateCart(cart).then(
      (value) {
        if (value.isLeft()) {
          debugPrint("Cart could not be updated to Firestore");
        }
      },
    );
    notifyListeners();
  }

  Future<dz.Either<ServerFailure, void>> handleAuth(
      BuildContext context) async {
    try {
      container.read(authProvider).authStateChanges().listen(
        (authUser) async {
          if (authUser == null) {
            _user = null;
            debugPrint('User is currently signed out!');
            context.router.root.navigate(MobileFormRoute());
          } else {
            context.read(mobileFormProvider).setUid(authUser.uid);
            await container.read(usersProvider).doc(authUser.uid).get().then(
              (DocumentSnapshot<User> userSnapshot) async {
                if (userSnapshot.exists) {
                  _user = userSnapshot.data();
                  _cart = _user!.cart;
                  await context.router.root.navigate(const HomeRoute());
                } else {
                  debugPrint('User requires registration');
                  await context.router.navigate(
                    RegistrationFormRoute(
                      asUpdate: false,
                    ),
                  );
                }
              },
            );
          }
        },
      );
      return const dz.Right(null);
    } on Exception {
      return dz.Left(ServerFailure());
    }
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
        orderId: await nanoid(5),
        orderItems: cart,
        value: getCartValue(cart),
      );
      container.read(orderRepositoryProvider).pushOrder(order);
      return const dz.Right(null);
    } on Exception {
      return dz.Left(ServerFailure());
    }
  }

  double getCartValue(Cart cart) {
    double _value = 0.0;
    for (final orderItem in cart.orderItems) {
      _value += orderItem.price;
    }
    return _value;
  }
}
