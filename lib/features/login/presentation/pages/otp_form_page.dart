import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/form_provider.dart';
import '../provider/user_firestore_provider.dart';
import '../widgets/sign_in_widgets.dart';

class OtpFormPage extends StatefulWidget {
  @override
  _OtpFormPageState createState() => _OtpFormPageState();
}

class _OtpFormPageState extends State<OtpFormPage> {
  final _otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          "Enter OTP",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        Form(
          key: _otpFormKey,
          child: PinInputField(),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () async {
            if (_otpFormKey.currentState!.validate()) {
              await context.read(userProvider).signInWithOTP(
                    context.read(formProvider).smsCode!,
                    context.read(formProvider).verificationId!,
                  );
              await context.read(userProvider).handleAuth(context);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          child: const Text(
            "Verify and Sign In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
