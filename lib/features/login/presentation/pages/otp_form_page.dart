import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/theme/theme_data.dart';
import '../../data/sources/user_auth_repository.dart';
import '../provider/mobile_otp_form_provider.dart';
import '../widgets/cutso_header_widget.dart';
import '../widgets/pin_input_widget.dart';

class OtpFormPage extends ConsumerWidget {
  final _otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      backgroundColor: kCream,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CutsoHeader(),
            SizedBox(height: 8.h),
            Text(
              "Enter OTP",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 4.h),
            Form(
              key: _otpFormKey,
              child: PinInputField(),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ArgonTimerButton(
                  initialTimer: 30,
                  height: 10.w,
                  width: 45.w,
                  minWidth: 35.w,
                  color: kOrange,
                  borderRadius: 5.w,
                  child: Text(
                    "RESEND OTP",
                    style: Theme.of(context).textTheme.button,
                  ),
                  loader: (timeLeft) {
                    return Text(
                      "WAIT | $timeLeft",
                      style: Theme.of(context).textTheme.button,
                    );
                  },
                  onTap: (startTimer, btnState) async {
                    if (btnState == ButtonState.Idle) {
                      final String number = watch(mobileFormProvider).mobileNo;
                      await watch(mobileFormProvider)
                          .verifyPhone(context, "+91$number");
                      startTimer(30);
                    }
                  },
                ),
                ArgonButton(
                  height: 10.w,
                  width: 36.w,
                  color: kOrange,
                  borderRadius: 5.w,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    child: const SpinKitRotatingCircle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (btnState == ButtonState.Idle &&
                        _otpFormKey.currentState!.validate() &&
                        watch(mobileFormProvider).status ==
                            AuthStatus.otpSent) {
                      startLoading();
                      final Either<AuthFailure, void> authRunner = await context
                          .read(userAuthRepositoryProvider)
                          .signInWithOTP(
                            watch(mobileFormProvider).smsCode,
                            watch(mobileFormProvider).verificationId,
                          );
                      stopLoading();
                      authRunner.fold(
                        (failure) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "Invalid Credentials",
                            ),
                          );
                        },
                        (_) async {
                          return watch(mobileFormProvider).handleAuth(context);
                        },
                      );
                    }
                  },
                  child: Text(
                    "SIGN IN",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
