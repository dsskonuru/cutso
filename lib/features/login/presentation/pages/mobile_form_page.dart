import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.gr.dart';
import '../provider/form_provider.dart';
import 'sign_in.dart';

class MobileFormPage extends StatefulWidget {
  @override
  _MobileFormPageState createState() => _MobileFormPageState();
}

class _MobileFormPageState extends State<MobileFormPage> {
  final _mobileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          "Sign in with mobile number",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 180.00,
          child: Form(
            key: _mobileFormKey,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Mobile Number',
                hintStyle: TextStyle(
                  color: Colors.white70,
                ),
                // error
              ),
              autocorrect: false,
              onChanged: (number) =>
                  context.read(formProvider).setPhoneNo(int.parse(number)),
              validator: (value) {
                value = value.toString();
                if (value.length != 10 ||
                    value.contains(RegExp(r'[A-Z]|[a-z]'))) {
                  return "Invalid Phone Number";
                }
                return null;
              },
            ),
          ),
        ),
        SizedBox(
          height: 12.00,
        ),
        Text(
          "10-digit Mobile Number",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 12),
        Consumer(builder: (context, watch, child) {
          return ElevatedButton(
            onPressed: () async {
              if (_mobileFormKey.currentState!.validate()) {
                String number = watch(formProvider).phoneNo.toString();
                debugPrint(number);
                await verifyPhone(context, "+91" + number);
                await context.router.navigate(OtpFormRoute());
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text(
              "Get Code",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () async {
            debugPrint('Going to home');
            await context.router.root.navigate(HomeRoute());
          },
          child: const Text(
            "Skip Sign In",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
