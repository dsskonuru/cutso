import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'top_painter_widget.dart';

class CutsoHeader extends StatelessWidget {
  const CutsoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(100.w, 27.h),
          painter: TopPainter(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.h),
          child: Hero(
            tag: "cutso_logo",
            child: Image(
              height: 16.h,
              image: const AssetImage('assets/images/cutso-logo-x3.png'),
            ),
          ),
        ),
      ],
    );
  }
}
