import 'package:auto_route/auto_route.dart';
import 'package:cutso/core/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../widgets/sign_in_widgets.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrange,
      body: Center(
        child: InkWell(
          onTap: () async => context.router.navigate(MobileFormRoute()),
          child: Hero(
            tag: "cutso_logo",
            child: Image(
              height: 60.h,
              image: const AssetImage('assets/images/logo-white.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(100.w, 27.h),
          painter: TopPainter(),
        ),
        SizedBox(
          height: 9.h,
        ),
        Hero(
          tag: "cutso_logo",
          child: Image(
            height: 18.h,
            image: const AssetImage('assets/images/logo-color.png'),
          ),
        ),
      ],
    );
  }
}
