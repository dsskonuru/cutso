import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../provider/animation_provider.dart';
import '../provider/form_provider.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final animateNotifier = watch(animationProvider);
        return GestureDetector(
          onTap: () => animateNotifier.setAnimation(true),
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeIn,
            transform:
                Matrix4.translationValues(0, animateNotifier.logoHeight, 0),
            child: Image(
              height: animateNotifier.animate ? 100 : 200,
              image: const AssetImage('assets/images/logo-white.png'),
            ),
          ),
        );
      },
    );
  }
}

class BottomAnimation extends StatelessWidget {
  const BottomAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (context, watch, child) {
        final animateNotifier = watch(animationProvider);
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          top:
              animateNotifier.animate ? screenHeight * 0.8 : screenHeight * 0.5,
          child: CustomPaint(
            size: Size(screenWidth, screenHeight / 2),
            painter: BottomPainter(),
          ),
        );
      },
    );
  }
}

class TopAnimation extends StatelessWidget {
  const TopAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (context, watch, child) {
        final animateNotifier = watch(animationProvider);
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          bottom: animateNotifier.animate
              ? screenHeight * 0.75
              : screenHeight * 0.5,
          child: CustomPaint(
            size: Size(screenWidth, screenHeight / 2),
            painter: TopPainter(),
          ),
        );
      },
    );
  }
}

// Painters

class LoginBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xaaff6f00),
          Color(0xccff6f00),
        ],
      ).createShader(Rect.fromLTRB(0, 0, width, height));

    final Path bottomOval = Path();
    bottomOval.addRect(Rect.fromLTWH(0.00, 0.00, width, height));
    bottomOval.quadraticBezierTo(width * 0.5, height * 0.3, width, 0.00);
    canvas.drawPath(bottomOval, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}

class LoginTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xaaff6f00),
          Color(0xccff6f00),
          Color(0xffff6f00),
        ],
      ).createShader(Rect.fromLTRB(0, 0, width, height));

    final Path topOval = Path();
    topOval.addRect(Rect.fromLTRB(0.00, 0.00, width, height));
    topOval.moveTo(0, height);
    topOval.quadraticBezierTo(width * 0.5, height * 1.3, width, height);
    canvas.drawPath(topOval, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}

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
    paint.color = const Color(0xffff6f00);
    canvas.drawPath(topOval, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}

class BottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    final Paint paint = Paint();
    final Path bottomOval = Path();
    bottomOval.addRect(Rect.fromLTWH(0.00, 0.00, width, height));
    bottomOval.quadraticBezierTo(width * 0.5, height * 0.3, width, 0.00);
    paint.color = const Color(0xffff6f00);
    canvas.drawPath(bottomOval, paint);
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
    color: const Color(0x00ff6f00),
    borderRadius: BorderRadius.circular(10.00),
    border: Border.all(
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PinPut(
      eachFieldWidth: 42.00,
      eachFieldHeight: 42.00,
      fieldsCount: 6,
      fieldsAlignment: MainAxisAlignment.spaceEvenly,
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20.00),
      onChanged: (pin) => context.read(formProvider).setSmsCode(pin),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please provide the PIN';
        }
        return null;
      },
    );
  }
}
