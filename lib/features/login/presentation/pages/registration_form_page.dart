import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';
import '../provider/form_provider.dart';
import '../provider/user_firestore_provider.dart';

class RegistrationFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        const Text(
          "REGISTRATION",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                gapPadding: 8.0,
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
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid Email Address")));
              }
            },
          ),
        ),
        const SizedBox(height: 12),
        Consumer(builder: (context, watch, child) {
          return ElevatedButton(
            onPressed: () async {
              await context.read(userProvider).registerUser(UserModel(
                    uid: context.read(formProvider).uid,
                    full_name: context.read(formProvider).name,
                    phone: context.read(formProvider).phoneNo,
                    email: context.read(formProvider).email,
                    addresses: null,
                    cart: null,
                  ));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }),
      ],
    );
  }
}
