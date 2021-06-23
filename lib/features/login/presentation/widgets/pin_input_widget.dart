import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../../../core/theme/theme_data.dart';
import '../provider/mobile_otp_form_provider.dart';

class PinInputField extends StatefulWidget {
  @override
  _PinInputFieldState createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kCreamDark,
    borderRadius: BorderRadius.circular(10.00),
  );

  @override
  Widget build(BuildContext context) {
    // ? should change dims
    return PinPut(
      eachFieldWidth: 42.0,
      eachFieldHeight: 42.0,
      fieldsCount: 6,
      fieldsAlignment: MainAxisAlignment.spaceEvenly,
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
      textStyle: Theme.of(context).textTheme.bodyText2,
      onChanged: (pin) => context.read(mobileFormProvider).smsCode = pin,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please provide the PIN';
        }
        return null;
      },
    );
  }
}
