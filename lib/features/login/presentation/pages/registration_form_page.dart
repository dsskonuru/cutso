import 'package:auto_route/auto_route.dart';
import 'package:cutso/features/login/presentation/provider/mobile_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../provider/registration_form_provider.dart';
import 'onboarding_page.dart';

final emailValidation = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class RegistrationFormPage extends ConsumerWidget {
  final bool asUpdate;
  RegistrationFormPage({@PathParam('asUpdate') required this.asUpdate});

  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Form(
        key: _registrationFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              SizedBox(height: 4.h), //24
              Text(
                asUpdate ? "Edit Detials" : "Registration",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: "Name",
                  ),
                  autocorrect: false,
                  onChanged: (name) =>
                      watch(registrationFormProvider).setName(name),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
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
                  onChanged: (email) =>
                      watch(registrationFormProvider).setEmail(email),
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
                  padding: const EdgeInsets.only(
                      left: 12.00, right: 12.00, top: 12.00),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    initialValue: watch(mobileFormProvider).mobileNo,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mobile Number',
                    ),
                    autocorrect: false,
                    onChanged: (number) => context
                        .read(registrationFormProvider)
                        .setMobileNo(number),
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
              ElevatedButton(
                onPressed: () async {
                  if (_registrationFormKey.currentState!.validate()) {
                    if (asUpdate) {
                      //TODO: Update Detials
                      await context.router.pop();
                    } else {
                      await context.router
                          .navigate(AddressFormRoute(asUpdate: false));
                    }
                  }
                },
                style: buttonStyle,
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
