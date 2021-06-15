import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../provider/mobile_otp_form_provider.dart';
import '../widgets/sign_in_widgets.dart';

class MobileFormPage extends ConsumerWidget {
  MobileFormPage({Key? key}) : super(key: key);
  final _mobileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
              "Sign in with mobile number",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 18.w, right: 18.w),
              child: Form(
                key: _mobileFormKey,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: '9876543210',
                  ),
                  autocorrect: false,
                  initialValue: watch(mobileFormProvider).mobileNo,
                  onChanged: (number) =>
                      watch(mobileFormProvider).mobileNo =number,
                  validator: (value) {
                    value = value.toString();
                    if (value.length != 10 ||
                        value.contains(RegExp(r"\[A-Z]|[a-z]"))) {
                      return "Invalid Number";
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "10-digit Mobile Number",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 2.h),
            ArgonButton(
              height: 9.w,
              width: 36.w,
              color: kOrange,
              borderRadius: 0.5.w,
              loader: Container(
                padding: const EdgeInsets.all(10),
                child: const SpinKitRotatingCircle(
                  color: Colors.white,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                if (btnState == ButtonState.Idle &&
                    _mobileFormKey.currentState!.validate()) {
                  startLoading();
                  final String number = watch(mobileFormProvider).mobileNo;
                  debugPrint(number);
                  await watch(mobileFormProvider)
                      .verifyPhone(context, "+91$number");
                  stopLoading();
                  await context.router.navigate(const OtpFormRoute());
                }
              },
              child: Text(
                "GET CODE",
                style: Theme.of(context).textTheme.button,
              ),
            ),
            SizedBox(height: 2.h),
            TextButton(
              onPressed: () async {
                if (_mobileFormKey.currentState!.validate()) {
                  return context.router.root.navigate(const HomeRoute());
                }
              },
              child: Text(
                "SKIP SIGN IN",
                style: Theme.of(context).textTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
