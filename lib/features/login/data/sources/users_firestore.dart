import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../domain/entities/user.dart';
import '../../presentation/provider/form_provider.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, UserModel?>> getUser(String uid);
  Future<Either<Failure, UserModel>> registerUser(UserModel user);
  Future<void> signOut();
  Future<void> signIn(AuthCredential authCredential);
  Future<void> signInWithOTP(String smsCode, String verfId);
  Future<void> updateUserCart(Cart cart);
}

class UserFirestore implements UserDataSource {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;

  bool isLoading = true;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  UserModel? get user => _user;

  @override
  Future<void> signIn(AuthCredential authCreds) async =>
      _auth.signInWithCredential(authCreds);

  @override
  Future<void> signInWithOTP(String smsCode, String verfId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verfId, smsCode: smsCode);
    signIn(authCreds);
  }

  @override
  Future<Either<Failure, UserModel?>> getUser(String uid) async {
    try {
      UserModel? user;
      _firestore
          .collection('users')
          .doc(uid)
          .snapshots()
          .listen((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        user = UserModel.fromJson(documentSnapshot.data()!);
      });
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerUser(UserModel user) async {
    try {
      _firestore..collection('users').doc(user.uid).set(user.toJson());
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> signOut() async => _auth.signOut();

  // Handles Auth
  Future<void> handleAuth(BuildContext context) async {
    _auth.authStateChanges().listen(
      (user) async {
        if (user == null) {
          debugPrint('User is currently signed out!');
          context.router.root.navigate(LoginRouter());
        } else {
          context.read(formProvider).setUid(user.uid);
          _firestore.collection('users').doc(user.uid).get().then(
            (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
              if (documentSnapshot.exists) {
                print(documentSnapshot.data()!);
                _user = UserModel.fromJson(documentSnapshot.data()!);
                print('Document data: ${documentSnapshot.data()}');
                context.router.root.navigate(HomeRoute());
              } else {
                context.read(formProvider).setUid(user.uid);
                print('Document does not exist on the database');
                context.router.navigate(RegistrationFormRoute());
              }
            },
          );
        }
      },
    );
  }

  @override
  Future<void> updateUserCart(Cart cart) async =>
      _firestore.collection('users').doc(user!.uid).set(cart.toJson());
}
