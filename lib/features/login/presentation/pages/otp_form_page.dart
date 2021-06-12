import 'package:cutso/features/login/data/sources/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/theme_data.dart';
import '../provider/mobile_form_provider.dart';
import '../provider/user_actions_provider.dart';
import '../widgets/sign_in_widgets.dart';

class OtpFormPage extends StatefulWidget {
  const OtpFormPage({Key? key}) : super(key: key);
  @override
  _OtpFormPageState createState() => _OtpFormPageState();
}

class _OtpFormPageState extends State<OtpFormPage> {
  final _otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(100.w, 27.h),
                  painter: TopPainter(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 9.h),
                  child: Hero(
                    tag: "cutso_logo",
                    child: Image(
                      height: 18.h,
                      image: const AssetImage('assets/images/logo-white.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter OTP",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 4.h),
            Form(
              key: _otpFormKey,
              child: PinInputField(),
            ),
            SizedBox(height: 4.h), // TODO: Add resend OTP
            ElevatedButton(
              onPressed: () async {
                if (_otpFormKey.currentState!.validate()) {
                  await context.read(userRepositoryProvider).signInWithOTP(
                        context.read(mobileFormProvider).smsCode!,
                        context.read(mobileFormProvider).verificationId!,
                      );
                  await context.read(userActionsProvider).handleAuth(context);
                }
              },
              style: buttonStyle,
              child: Text(
                "SIGN IN",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
