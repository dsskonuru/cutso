import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../login/data/models/user.dart';

class ProfileCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final User? _user = watch(userActionsProvider).user;
    if (_user == null) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: Card(
          color: kCreamLight,
          elevation: 7.0,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              height: 18.h,
              width: 100.w,
              child: Center(
                child: TextButton(
                    onPressed: () =>
                        context.router.navigate(MobileFormRoute()),
                    child: const Text("Click here to Login")),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: kCreamLight,
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: SizedBox(
              width: 100.w,
              height: 20.h,
              child: Column(
                children: [
                  Text(
                    "Hi! ${_user.fullName}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_user.email),
                  Text(_user.phone),
                  TextButton(
                    onPressed: () async => context.router.navigate(
                      RegistrationFormRoute(asUpdate: true),
                    ),
                    child: const Text('Edit Details'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
