import 'package:cutso/core/providers/firebase_provider.dart';
import 'package:cutso/features/login/data/sources/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';

final mobileFormProvider =
    ChangeNotifierProvider((ref) => MobileFormNotifier());

class MobileFormNotifier extends ChangeNotifier {
  String? _verificationId;
  String? _smsCode;
  bool? _codeSent;
  String? _mobileNo;

  String? _uid;

  String? get verificationId => _verificationId;
  String? get smsCode => _smsCode;
  bool? get codeSent => _codeSent;
  String? get mobileNo => _mobileNo;

  String? get uid => _uid;

  void setVerificationId(String id) {
    _verificationId = id;
    notifyListeners();
  }

  void setSmsCode(String code) {
    _smsCode = code;
    notifyListeners();
  }

  void setCodeSent({required bool codeSent}) {
    _codeSent = codeSent;
    notifyListeners();
  }

  void setMobileNo(String number) {
    _mobileNo = number;
    notifyListeners();
  }

  void setUid(String? uid) {
    _uid = uid;
    notifyListeners();
  }

  Future<void> verifyPhone(BuildContext context, String mobileNo) async =>
      container.read(authProvider).verifyPhoneNumber( //TODO: Fix message resend & alert invalid OTP 
            phoneNumber: mobileNo,
            verificationCompleted: (AuthCredential authCredential) {
              container.read(userRepositoryProvider).signIn(authCredential);
            },
            verificationFailed: (FirebaseAuthException verificationFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(verificationFailed.message!)));
            },
            codeSent: (String verificationId, int? forceResend) {
              container
                  .read(mobileFormProvider)
                  .setVerificationId(verificationId);
              container.read(mobileFormProvider).setCodeSent(codeSent: true);
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
}
