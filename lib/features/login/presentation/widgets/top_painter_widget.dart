import 'package:flutter/rendering.dart';

import '../../../../core/theme/theme_data.dart';

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