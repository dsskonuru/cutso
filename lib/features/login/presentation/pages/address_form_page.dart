import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../data/models/cart.dart';
import '../../data/models/user.dart';
import '../../data/sources/user_repository.dart';
import '../provider/address_form_provider.dart';
import '../provider/mobile_form_provider.dart';
import '../provider/registration_form_provider.dart';
import 'onboarding_page.dart';

class AddressFormPage extends ConsumerWidget {
  final bool asUpdate;
  AddressFormPage({@PathParam('asUpdate') required this.asUpdate});

  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool _isSelected = false;
    return Scaffold(
      body: Form(
        key: _addressFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              SizedBox(height: 4.h), //24
              Text(
                "Address",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: 'Name',
                  ),
                  autocorrect: false,
                  onChanged: (addressName) => context
                      .read(addressFormProvider)
                      .setAddressName(addressName),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: 'Line',
                  ),
                  autocorrect: false,
                  onChanged: (address) =>
                      context.read(addressFormProvider).setAddressLine(address),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address line';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: 'Landmark',
                  ),
                  autocorrect: false,
                  onChanged: (landmark) => context
                      .read(addressFormProvider)
                      .setAddressLandmark(landmark),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some landmark';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 2.h),
              ElevatedButton(
                  onPressed: () async {
                    if (!_isSelected) {
                      final Location location = Location();
                      late bool _serviceEnabled;
                      late PermissionStatus _permissionGranted;
                      late LocationData _locationData;

                      _serviceEnabled = await location.serviceEnabled();
                      if (!_serviceEnabled) {
                        _serviceEnabled = await location.requestService();
                        if (!_serviceEnabled) {
                          return;
                        }
                      }
                      _permissionGranted = await location.hasPermission();
                      if (_permissionGranted == PermissionStatus.denied) {
                        _permissionGranted = await location.requestPermission();
                        if (_permissionGranted != PermissionStatus.granted) {
                          return;
                        }
                      }
                      _locationData = await location.getLocation();
                      context.read(addressFormProvider).setLocation(GeoPoint(
                          _locationData.latitude!, _locationData.longitude!));

                      _isSelected = true;
                    }
                  },
                  style: buttonStyle,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isSelected)
                        const Icon(Icons.check_circle_rounded)
                      else
                        const Icon(
                          Icons.gps_fixed_rounded,
                        ),
                      SizedBox(width: 10.w),
                      Text(
                        "GET LOCATION",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  )),
              SizedBox(height: 2.h),
              ElevatedButton(
                onPressed: () async {
                  if (_addressFormKey.currentState!.validate()) {
                    final dz.Either<ServerFailure, User> _user = await context
                        .read(userRepositoryProvider)
                        .registerUser(
                          User(
                            uid: context.read(mobileFormProvider).uid!,
                            fullName:
                                context.read(registrationFormProvider).name!,
                            phone: context.read(mobileFormProvider).mobileNo!,
                            email:
                                context.read(registrationFormProvider).email!,
                            address:
                                context.read(addressFormProvider).getAddress(),
                            cart: Cart.empty(),
                          ),
                        );
                    _user.fold((l) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Server Side Error')));
                    }, (user) async {
                      debugPrint(user.toJson().toString());
                      await context.router.navigate(const HomeRoute());
                    });
                  }
                },
                style: buttonStyle,
                child: Text(
                  "SUBMIT",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
