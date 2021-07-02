import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../provider/mobile_otp_form_provider.dart';
import '../provider/registration_form_provider.dart';
import '../widgets/top_painter_widget.dart';

final emailValidation = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class RegistrationFormPage extends ConsumerWidget {
  final bool asUpdate;
  RegistrationFormPage({@PathParam('asUpdate') required this.asUpdate});

  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      backgroundColor: kCream,
      body: SingleChildScrollView(
        child: Form(
          key: _registrationFormKey,
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
                        image: const AssetImage('assets/images/cutso-logo.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                asUpdate ? "Edit Detials" : "Registration",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: "Name",
                  ),
                  autocorrect: false,
                  initialValue: watch(registrationFormProvider).name,
                  onChanged: (name) =>
                      watch(registrationFormProvider).name = name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      gapPadding: 8.00,
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: "Email",
                  ),
                  autocorrect: false,
                  initialValue: watch(registrationFormProvider).email,
                  onChanged: (email) =>
                      watch(registrationFormProvider).email = email,
                  validator: (email) {
                    final bool _isValid =
                        emailValidation.hasMatch(email.toString());
                    if (!_isValid) {
                      return "Invalid Email Address";
                    }
                    return null;
                  },
                ),
              ),
              if (asUpdate)
                Padding(
                  padding: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: Theme.of(context).textTheme.bodyText2,
                    
                    keyboardType: TextInputType.phone,
                    initialValue: watch(mobileFormProvider).mobileNo,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        gapPadding: 8.00,
                        borderSide: BorderSide(color: Colors.white, width: 5),
                      ),
                      labelText: "Mobile Number",
                    ),
                    autocorrect: false,
                    onChanged: (number) =>
                        watch(registrationFormProvider).mobileNo = number,
                    validator: (value) {
                      value = value.toString();
                      if (value.length != 10 ||
                          value.contains(RegExp(r"\[A-Z]|[a-z]"))) {
                        return "Invalid Phone Number";
                      }
                      return null;
                    },
                  ),
                ),
              SizedBox(height: 2.h),
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
                      _registrationFormKey.currentState!.validate()) {
                    startLoading();
                    if (asUpdate) {
                      watch(userActionsProvider).updateDetails(
                        watch(registrationFormProvider).name!,
                        watch(registrationFormProvider).email!,
                        watch(registrationFormProvider).mobileNo!,
                      );
                      stopLoading();
                      await context.router.pop();
                    } else {
                      stopLoading();
                      await context.router
                          .navigate(AddressFormRoute(asUpdate: false));
                    }
                  }
                },
                child: Text(
                  asUpdate ? "UPDATE" : "CONTINUE",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
