import 'package:auto_route/auto_route.dart';
import '../../router/router.gr.dart';
import '../../services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'sign_in_ui.dart';

class FormNotifier extends ChangeNotifier {
  String? _phoneNo;
  String? _verificationId;
  String? _smsCode;
  bool? _codeSent;

  String? _name;
  String? _email;

  String? get phoneNo => _phoneNo;
  String? get verificationId => _verificationId;
  String? get smsCode => _smsCode;
  bool? get codeSent => _codeSent;

  String? get name => _name;
  String? get email => _email;

  void setPhoneNo(String number) {
    _phoneNo = number;
    notifyListeners();
  }

  void setVerificationId(String id) {
    _verificationId = id;
    notifyListeners();
  }

  void setSmsCode(String code) {
    _smsCode = code;
    notifyListeners();
  }

  void setCodeSent(bool boolean) {
    _codeSent = boolean;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}

final formProvider = ChangeNotifierProvider((ref) => FormNotifier());

class LoginWrapperPage extends StatelessWidget {
  const LoginWrapperPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          LoginUI(),
          const TopAnimation(),
          const BottomAnimation(),
          Logo(),
        ],
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}

Future<void> verifyPhone(BuildContext context, String phoneNo) async =>
    await FirebaseService().auth.verifyPhoneNumber(
          phoneNumber: phoneNo,
          verificationCompleted: (AuthCredential authCredential) {
            FirebaseService().signIn(authCredential);
          },
          verificationFailed: (FirebaseAuthException verificationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(verificationFailed.message!)));
          },
          codeSent: (String verificationId, int? forceResend) {
            context.read(formProvider).setVerificationId(verificationId);
            context.read(formProvider).setCodeSent(true);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

class LoginUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double uiHeight = MediaQuery.of(context).size.height;
    final double uiWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: uiHeight * 0.2, bottom: uiHeight * 0.2),
      child: Consumer(builder: (context, watch, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(uiWidth, uiHeight * 0.6),
              painter: LoginTopPainter(),
            ),
            AutoRouter(),
          ],
        );
      }),
    );
  }
  // Form Handling
}

class MobileFormPage extends StatelessWidget {
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
        TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Mobile Number',
            hintStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
          autocorrect: false,
          onChanged: (number) => context.read(formProvider).setPhoneNo(number),
          validator: (value) {
            value = value.toString();
            if (value.length != 10 || value.contains(RegExp(r'[A-Z]|[a-z]'))) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid Phone Number")));
            }
          },
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
              String number = watch(formProvider).phoneNo.toString();
              debugPrint(number);
              await verifyPhone(context, "+91" + number);
              await context.router.navigate(OtpFormRoute());
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

class OtpFormPage extends StatelessWidget {
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
        PinInputField(),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () async {
            await FirebaseService().signInWithOTP(
              context.read(formProvider).smsCode!,
              context.read(formProvider).verificationId!,
            );
            await FirebaseService().handleAuth(context);
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
              await FirebaseService().registerUser(
                context.read(formProvider).name!,
                context.read(formProvider).email!,
              );
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

class PinInputField extends StatefulWidget {
  @override
  _PinInputFieldState createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  final _pinController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color(0x00ff6f00),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PinPut(
      eachFieldWidth: 42.0,
      eachFieldHeight: 42.0,
      fieldsCount: 6,
      fieldsAlignment: MainAxisAlignment.spaceEvenly,
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20.0),
      controller: _pinController,
      onSubmit: (_) =>
          context.read(formProvider).setSmsCode(_pinController.text),
    );
  }
}
