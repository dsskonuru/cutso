import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';

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