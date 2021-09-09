import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../provider/mobile_otp_form_provider.dart';
import '../widgets/cutso_header_widget.dart';

class MobileFormPage extends StatelessWidget {
  MobileFormPage({Key? key}) : super(key: key);
  final _mobileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CutsoHeader(),
            SizedBox(height: 8.h),
            Text(
              "Sign in with mobile number",
              style: Theme.of(context).textTheme.headline6,
            ),
            _MobileNumberField(mobileFormKey: _mobileFormKey),
            SizedBox(height: 2.h),
            Text(
              "10-digit Mobile Number",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 2.h),
            _GetCodeButton(mobileFormKey: _mobileFormKey),
            SizedBox(height: 2.h),
            const _SkipSignInButton(),
          ],
        ),
      ),
    );
  }
}

class _SkipSignInButton extends StatelessWidget {
  const _SkipSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.router.root.navigate(const HomeRoute()),
      child: Text(
        "SKIP SIGN IN",
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

class _GetCodeButton extends ConsumerWidget {
  const _GetCodeButton({
    Key? key,
    required GlobalKey<FormState> mobileFormKey,
  })  : _mobileFormKey = mobileFormKey,
        super(key: key);

  final GlobalKey<FormState> _mobileFormKey;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ArgonButton(
      height: 9.w,
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
            _mobileFormKey.currentState!.validate()) {
          startLoading();
          final String number = watch(mobileFormProvider).mobileNo!;
          debugPrint(number);
          await watch(mobileFormProvider).verifyPhone(context, "+91$number");
          stopLoading();
          await context.router.navigate(const OtpFormRoute());
        }
      },
      child: Text(
        "GET CODE",
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

class _MobileNumberField extends ConsumerWidget {
  const _MobileNumberField({
    Key? key,
    required GlobalKey<FormState> mobileFormKey,
  })  : _mobileFormKey = mobileFormKey,
        super(key: key);

  final GlobalKey<FormState> _mobileFormKey;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 18.w, right: 18.w),
      child: Form(
        key: _mobileFormKey,
        child: TextFormField(
          textAlign: TextAlign.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Theme.of(context).textTheme.bodyText1,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: '9876543210',
          ),
          autocorrect: false,
          initialValue: watch(mobileFormProvider).mobileNo,
          onChanged: (number) => watch(mobileFormProvider).mobileNo = number,
          validator: (value) {
            value = value.toString();
            if (value.length != 10 || value.contains(RegExp(r"\[A-Z]|[a-z]"))) {
              return "Invalid Number";
            }
            return null;
          },
        ),
      ),
    );
  }
}
