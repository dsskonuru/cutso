import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../../../core/theme/theme_data.dart';
import '../provider/mobile_otp_form_provider.dart';

// Painters

class TopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;
    final Paint paint = Paint();

    final Path topOval = Path();
    topOval.addRect(Rect.fromLTRB(0.00, 0.00, width, height));
    topOval.moveTo(0, height);
    topOval.quadraticBezierTo(width * 0.5, height * 1.3, width, height);
    paint.color = kOrange;
    canvas.drawPath(topOval, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}

// Pin Input Field

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
