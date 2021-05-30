import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../domain/entities/user.dart';
import '../../presentation/provider/form_provider.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<Either<ServerFailure, void>> registerUser(UserModel user);
  Future<Either<ServerFailure, void>> signIn(AuthCredential authCredential);
  Future<Either<ServerFailure, void>> signInWithOTP(
      String smsCode, String verfId);
  Future<Either<ServerFailure, UserModel>> getUser(String uid);
  Future<Either<ServerFailure, Cart>> getCart();
  Future<Either<ServerFailure, void>> updateCart(Cart cart);
  Future<Either<ServerFailure, void>> signOut();
  Future<Either<ServerFailure, void>> handleAuth(BuildContext context);
}

class UserFirestore implements UserDataSource {
  final _auth = FirebaseAuth.instance;
  final _usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  UserModel? _user;
  UserModel? get user => _user;
  void setUser(UserModel? user) => _user = user;

  Cart _cart = Cart.empty();
  Cart get cart => _cart;
  void setCart(Cart cart) => _cart = cart;

  @override
  Future<Either<ServerFailure, UserModel>> registerUser(UserModel user) async {
    try {
      await _usersRef.doc(user.uid).set(user);
      debugPrint(user.toJson().toString());
      return Right(user);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> signIn(AuthCredential authCreds) async {
    try {
      await _auth.signInWithCredential(authCreds);
      return Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> signInWithOTP(
      String smsCode, String verfId) async {
    try {
      AuthCredential authCreds = PhoneAuthProvider.credential(
          verificationId: verfId, smsCode: smsCode);
      Either<ServerFailure, void> signInOrFailure = await signIn(authCreds);
      if (signInOrFailure.isRight())
        return Right(null);
      else
        return Left(ServerFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, UserModel>> getUser(String uid) async {
    try {
      _user =
          await _usersRef.doc(uid).get().then((snapshot) => snapshot.data()!);
      return Right(_user!);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<ServerFailure, Cart>> getCart() async {
    try {
      if (_user == null) return Right(Cart.empty());
      _cart = _user!.cart;
      return Right(_cart);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateCart(Cart cart) async {
    try {
      _cart = cart;
      _usersRef.doc(_user!.uid).update({'cart': cart.toJson()});
      return Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> signOut() async {
    try {
      await _auth.signOut();
      setUser(null);
      return Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> handleAuth(BuildContext context) async {
    try {
      _auth.authStateChanges().listen(
        (authUser) async {
          if (authUser == null) {
            debugPrint('User is currently signed out!');
            context.router.root.navigate(LoginRouter());
          } else {
            context.read(formProvider).setUid(authUser.uid);
            await _usersRef.doc(authUser.uid).get().then(
              (DocumentSnapshot<UserModel> userSnapshot) async {
                if (userSnapshot.exists) {
                  setUser(userSnapshot.data()!);
                  setCart(_user!.cart);
                  debugPrint(_user!.uid + _user!.full_name);
                  await context.router.root.navigate(HomeRoute());
                } else {
                  debugPrint('User requires registration');
                  await context.router.navigate(RegistrationFormRoute());
                }
              },
            );
          }
        },
      );
      return Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}

// TODO: Setup Phone Auth for iOS
