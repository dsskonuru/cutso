import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../main.dart';
import '../models/user.dart';

abstract class UserAuthRepositoryDataSource {
  Future<Either<Failure, void>> registerUser(User user);
  Future<Either<Failure, void>> signIn(fauth.AuthCredential authCredential);
  Future<Either<Failure, void>> signInWithOTP(String smsCode, String verfId);
  Future<Either<Failure, void>> signOut();
}

final userAuthRepositoryProvider =
    Provider<UserAuthRepository>((ref) => UserAuthRepository());

class UserAuthRepository implements UserAuthRepositoryDataSource {
  @override
  Future<Either<AuthFailure, void>> registerUser(User user) async {
    try {
      await container.read(usersProvider).doc(user.uid).set(user);
      container.read(userActionsProvider).user = user;
      container.read(crashlyticsProvider).log(user.toJson().toString());
      return const Right(null);
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return Left(AuthFailure(error.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signIn(
      fauth.AuthCredential authCreds) async {
    try {
      await container.read(authProvider).signInWithCredential(authCreds);
      return const Right(null);
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return Left(AuthFailure(error.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signInWithOTP(
      String smsCode, String verfId) async {
    try {
      final fauth.AuthCredential authCreds = fauth.PhoneAuthProvider.credential(
          verificationId: verfId, smsCode: smsCode);
      return await signIn(authCreds);
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return Left(AuthFailure(error.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await container.read(authProvider).signOut();
      container.read(userActionsProvider).user = null;
      return const Right(null);
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return Left(AuthFailure(error.toString()));
    }
  }
}

// TODO: Setup Phone Auth for iOS
