import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/router/router.gr.dart';
import '../../../login/data/models/user_model.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/provider/user_firestore_provider.dart';

class AddressCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    UserModel? _user = watch(userProvider).user;
    if (_user == null) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: Card(
          elevation: 7.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: TextButton(
                  onPressed: () => context.router.navigate(LoginRouter()),
                  child: Text("Click here to Login")),
            ),
          ),
        ),
      );
    }
    Address _address = _user.address;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _address.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_address.line),
              Text(_address.landmark),
              TextButton(
                  onPressed: () =>
                      context.router.navigate(RegistrationForm2Route()),
                  child: Text('Edit Address'))
            ],
          ),
        ),
      ),
    );
  }
}
