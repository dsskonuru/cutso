import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/form_provider.dart';
import '../provider/user_firestore_provider.dart';
import '../widgets/sign_in_widgets.dart';

class LoginWrapperPage extends StatelessWidget {
  const LoginWrapperPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          LoginUI(),
          const TopAnimation(),
          const BottomAnimation(),
          Logo(),
        ],
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}

Future<void> verifyPhone(BuildContext context, String phoneNo) async =>
    await context.read(userProvider).auth.verifyPhoneNumber(
          phoneNumber: phoneNo,
          verificationCompleted: (AuthCredential authCredential) {
            context.read(userProvider).signIn(authCredential);
          },
          verificationFailed: (FirebaseAuthException verificationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(verificationFailed.message!)));
          },
          codeSent: (String verificationId, int? forceResend) {
            context.read(formProvider).setVerificationId(verificationId);
            context.read(formProvider).setCodeSent(true);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

class LoginUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double uiHeight = MediaQuery.of(context).size.height;
    final double uiWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: uiHeight * 0.2, bottom: uiHeight * 0.2),
      child: Consumer(builder: (context, watch, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(uiWidth, uiHeight * 0.6),
              painter: LoginTopPainter(),
            ),
            AutoRouter(),
          ],
        );
      }),
    );
  }
}
