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
              width: 100.w,
              child: Center(
                child: TextButton(
                  onPressed: () => context.router.navigate(MobileFormRoute()),
                  child: Text(
                    "Click here to Login",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Hi! ${_user.fullName}",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  Text(
                    _user.email,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    _user.phone,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                    onPressed: () async => context.router.navigate(
                      RegistrationFormRoute(asUpdate: true),
                    ),
                    child: Text(
                      'EDIT DETAILS',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: kOrange),
                    ),
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
