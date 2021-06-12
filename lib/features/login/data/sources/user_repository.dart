import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../main.dart';
import '../models/user.dart';

abstract class UserDataSource {
  Future<Either<ServerFailure, void>> registerUser(User user);
  Future<Either<ServerFailure, void>> signIn(
      fauth.AuthCredential authCredential);
  Future<Either<ServerFailure, void>> signInWithOTP(
      String smsCode, String verfId);
  Future<Either<ServerFailure, void>> signOut();
}

final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository());

class UserRepository implements UserDataSource {
  @override
  Future<Either<ServerFailure, User>> registerUser(User user) async {
    try {
      await container.read(usersProvider).doc(user.uid).set(user);
      debugPrint(user.toJson().toString());
      return Right(user);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> signIn(
      fauth.AuthCredential authCreds) async {
    try {
      await container.read(authProvider).signInWithCredential(authCreds);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> signInWithOTP(
      String smsCode, String verfId) async {
    try {
      final fauth.AuthCredential authCreds = fauth.PhoneAuthProvider.credential(
          verificationId: verfId, smsCode: smsCode);
      final Either<ServerFailure, void> signInOrFailure =
          await signIn(authCreds);
      if (signInOrFailure.isRight()) {
        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, void>> signOut() async {
    try {
      await container.read(authProvider).signOut();
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}

// TODO: Setup Phone Auth for iOS
