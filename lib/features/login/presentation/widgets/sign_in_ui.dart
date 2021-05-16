import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SignInPageState {
  MOBILE_NUMBER_FORM,
  OTP_FORM,
  REGISTER_FORM,
}

class AnimateNotifier extends ChangeNotifier {
  bool _animate = false;
  double _logoHeight = 0;
  SignInPageState _state = SignInPageState.MOBILE_NUMBER_FORM;

  SignInPageState get state => _state;
  bool get animate => _animate;
  double get logoHeight => _logoHeight;

  void setAnimation(bool b) {
    _animate = b;
    _logoHeight = _animate ? -200 : 0;
    notifyListeners();
  }

  void setLoginState(SignInPageState state) {
    _state = state;
    notifyListeners();
  }
}

final animationProvider = ChangeNotifierProvider((ref) => AnimateNotifier());

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
                Matrix4.translationValues(0, animateNotifier._logoHeight, 0),
            child: Image(
              height: animateNotifier._animate ? 100 : 200,
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
          top: animateNotifier._animate
              ? screenHeight * 0.7
              : screenHeight * 0.5,
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
          bottom: animateNotifier._animate
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
    bottomOval.addRect(Rect.fromLTWH(0.0, 0.0, width, height));
    bottomOval.quadraticBezierTo(width * 0.5, height * 0.3, width, 0.0);
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
    topOval.addRect(Rect.fromLTRB(0.0, 0.0, width, height));
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
    topOval.addRect(Rect.fromLTRB(0.0, 0.0, width, height));
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
    bottomOval.addRect(Rect.fromLTWH(0.0, 0.0, width, height));
    bottomOval.quadraticBezierTo(width * 0.5, height * 0.3, width, 0.0);
    paint.color = const Color(0xffff6f00);
    canvas.drawPath(bottomOval, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}
