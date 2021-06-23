import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../main.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrange,
      body: Center(
        child: InkWell(
          onTap: () async {
            if (container.read(userActionsProvider).user == null) {
              return context.router.navigate(MobileFormRoute());
            } else {
              return context.router.navigate(const HomeRoute());
            }
          },
          child: Hero(
            tag: "cutso_logo",
            child: Image(
              height: 60.h,
              image: const AssetImage('assets/images/cutso-logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
