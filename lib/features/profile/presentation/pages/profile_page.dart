import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../login/data/sources/user_auth_repository.dart';
import '../widgets/my_orders_widget.dart';
import '../widgets/profile_card_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () => context.router.pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.account_circle_rounded),
                        Text(
                          ' Profile',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              ProfileCard(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'Previous Orders',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const PreviousOrders(),
              const Divider(),
              ArgonButton(
                height: 9.w,
                width: 45.w,
                color: kOrange,
                borderRadius: 5.w,
                loader: Container(
                  padding: const EdgeInsets.all(10),
                  child: const SpinKitRotatingCircle(
                    color: Colors.white,
                  ),
                ),
                onTap: (startLoading, stopLoading, btnState) async {
                  if (btnState == ButtonState.Idle) {
                    startLoading();
                    watch(userAuthRepositoryProvider).signOut();
                    stopLoading();
                    await context.router.navigate(const OnboardingRoute());
                  }
                },
                child: Text(
                  'SIGN OUT',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
