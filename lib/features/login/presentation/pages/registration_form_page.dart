import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.gr.dart';
import '../provider/form_provider.dart';

class RegistrationFormPage extends StatefulWidget {
  @override
  _RegistrationFormPageState createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  GlobalKey<FormState> _registrationForm1Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationForm1Key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 54),
          const Text(
            "REGISTRATION",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2.00,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.00, right: 12.00, top: 12.00),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5),
                ),
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
              ),
              autocorrect: false,
              onChanged: (name) => context.read(formProvider).setName(name),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.00, right: 12.00, top: 12.00),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  gapPadding: 8.00,
                  borderSide: BorderSide(color: Colors.white, width: 5),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
              ),
              autocorrect: false,
              onChanged: (email) => context.read(formProvider).setEmail(email),
              validator: (email) {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email.toString());
                if (!emailValid) {
                  return "Invalid Email Address";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              if (_registrationForm1Key.currentState!.validate())
                await context.router.navigate(RegistrationForm2Route());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
