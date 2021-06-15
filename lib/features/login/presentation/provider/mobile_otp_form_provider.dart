import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cutso/features/login/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../main.dart';
import '../../data/sources/user_auth_repository.dart';

enum AuthStatus {
  unverified,
  otpSent,
  verified,
  verificationFailed,
}

final mobileFormProvider = ChangeNotifierProvider<MobileFormNotifier>(
    (ref) => MobileFormNotifier(),
    name: 'MobileForm');

class MobileFormNotifier extends ChangeNotifier {
  String _verificationId = '';
  String _smsCode = '';
  String _mobileNo = '';
  String _uid = '';

  AuthStatus status = AuthStatus.unverified;

  String get verificationId => _verificationId;
  String get smsCode => _smsCode;
  String get mobileNo => _mobileNo;
  String get uid => _uid;

  set verificationId(String verificationId) {
    _verificationId = verificationId;
    displayNotifier();
    notifyListeners();
  }

  set smsCode(String smsCode) {
    _smsCode = smsCode;
    displayNotifier();
    notifyListeners();
  }

  set mobileNo(String number) {
    _mobileNo = number;
    displayNotifier();
    notifyListeners();
  }

  set uid(String uid) {
    _uid = uid;
    container.read(crashlyticsProvider).setUserIdentifier(_uid);
    displayNotifier();
    notifyListeners();
  }

  void displayNotifier() {
    debugPrint("""
    {
      "mobile": $_mobileNo,
      "smsCode": $_smsCode,
      "uid": $_uid,
      "verificationID": $_verificationId,
    }
    """);
  }

  Future<void> verifyPhone(BuildContext context, String mobileNo) async =>
      container.read(authProvider).verifyPhoneNumber(
            phoneNumber: mobileNo,
            verificationCompleted: (fauth.AuthCredential authCredential) {
              status = AuthStatus.verified;
              container.read(userAuthRepositoryProvider).signIn(authCredential);
            },
            verificationFailed:
                (fauth.FirebaseAuthException firebaseAuthException) {
              container
                  .read(crashlyticsProvider)
                  .recordError(firebaseAuthException, null);
              // cannot get stack trace for firebaseAuthException
              status = AuthStatus.verificationFailed;
            },
            codeSent: (String _verificationId, int? forceResendingToken) {
              verificationId = _verificationId;
              status = AuthStatus.otpSent;
              // forceResendingToken only works with Android
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );

  Future<Either<AuthFailure, void>> handleAuth(BuildContext context) async {
    try {
      container.read(authProvider).authStateChanges().listen(
        (authUser) async {
          if (authUser == null) {
            container.read(userActionsProvider).user = null;
            container.read(crashlyticsProvider).log('User is signed out');
            await context.router.navigate(MobileFormRoute());
          } else {
            uid = authUser.uid;
            await container.read(usersProvider).doc(uid).get().then(
              (DocumentSnapshot<User> userSnapshot) async {
                if (userSnapshot.exists) {
                  container.read(crashlyticsProvider).log('User is signed in');
                  container.read(userActionsProvider).user =
                      userSnapshot.data();
                  await context.router.navigate(const HomeRoute());
                } else {
                  container
                      .read(crashlyticsProvider)
                      .log('User requires registration');
                  await context.router
                      .navigate(RegistrationFormRoute(asUpdate: false));
                }
              },
            );
          }
        },
      );
      return const Right(null);
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
      return Left(AuthFailure(error.toString()));
    }
  }
}
