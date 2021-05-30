import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../provider/form_provider.dart';
import '../provider/user_firestore_provider.dart';

class RegistrationForm2Page extends StatefulWidget {
  @override
  _RegistrationForm2PageState createState() => _RegistrationForm2PageState();
}

class _RegistrationForm2PageState extends State<RegistrationForm2Page> {
  GlobalKey<FormState> _registrationForm2Key = GlobalKey<FormState>();
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationForm2Key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 96),
          const Text(
            "ADDRESS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2.00,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.00, right: 12.00, top: 12.00),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5),
                ),
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
              ),
              autocorrect: false,
              onChanged: (addressName) =>
                  context.read(formProvider).setAddressName(addressName),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.00, right: 12.00, top: 12.00),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5),
                ),
                labelText: 'Line',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
              ),
              autocorrect: false,
              onChanged: (address) =>
                  context.read(formProvider).setAddressLine(address),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address line';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.00, right: 12.00, top: 12.00),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5),
                ),
                labelText: 'Landmark',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
              ),
              autocorrect: false,
              onChanged: (landmark) =>
                  context.read(formProvider).setAddressLandmark(landmark),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some landmark';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (!_isSelected) {
                  Location location = Location();
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
                  context.read(formProvider).setLocation(GeoPoint(
                      _locationData.latitude!, _locationData.longitude!));

                  setState(() {
                    _isSelected = true;
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    !_isSelected ? Colors.blue : Colors.lightBlue),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.gps_fixed_rounded,
                  ),
                  SizedBox(width: 12.00),
                  Text(
                    "Get Location",
                  ),
                ],
              )),
          Consumer(builder: (context, watch, child) {
            return ElevatedButton(
              onPressed: () async {
                print('LOL');
                if (_registrationForm2Key.currentState!.validate()) {
                  dz.Either<ServerFailure, UserModel> _user =
                      await context.read(userProvider).registerUser(UserModel(
                            uid: context.read(formProvider).uid!,
                            full_name: context.read(formProvider).name!,
                            phone: context.read(formProvider).phoneNo!,
                            email: context.read(formProvider).email!,
                            address: context.read(formProvider).getAddress(),
                            cart: Cart.empty(),
                          ));
                  _user.fold((l) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Server Side Error')));
                  }, (user) async {
                    debugPrint(user.toJson().toString());
                    await context.router.navigate(HomeRoute());
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
