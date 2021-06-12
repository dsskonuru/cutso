import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/router/router.gr.dart';
import '../../../login/data/models/address.dart';
import '../../../login/data/models/user.dart';
import '../../../login/presentation/provider/user_actions_provider.dart';

class AddressCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final User? _user = watch(userActionsProvider).user;
    if (_user == null) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: Card(
          elevation: 7.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: TextButton(
                  onPressed: () => context.router.navigate(MobileFormRoute()),
                  child: const Text("Click here to Login")),
            ),
          ),
        ),
      );
    }
    final Address _address = _user.address;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                _address.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_address.line),
              Text(_address.landmark),
              TextButton(
                onPressed: () async => context.router.navigate(
                  AddressFormRoute(asUpdate: true),
                ),
                child: const Text('Edit Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
