import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import '../../../../core/providers/firebase_provider.dart';
import '../../../../main_common.dart';
import '../../data/models/user.dart';

final addressFormProvider =
    ChangeNotifierProvider((ref) => AddressFormNotifier());

class AddressFormNotifier extends ChangeNotifier {
  String? _name;
  String? _line;
  String? _landmark;
  GeoPoint? _location;

  String? get name => _name;
  String? get line => _line;
  String? get landmark => _landmark;
  GeoPoint? get location => _location;
  
  bool hasGotLocation = false;

  set name(String? name) {
    _name = name;
    notifyListeners();
  }

  set line(String? line) {
    _line = line;
    notifyListeners();
  }

  set landmark(String? landmark) {
    _landmark = landmark;
    notifyListeners();
  }

  set location(GeoPoint? location) {
    _location = location;
    notifyListeners();
  }

  Address getAddress() {
    return Address(
      name: _name!,
      location: _location!,
      line: _line!,
      landmark: _landmark!,
    );
  }

  Future<void> getLocation() async {
    try {
      final Location _location = Location();
      late bool _serviceEnabled;
      late PermissionStatus _permissionGranted;
      late LocationData _locationData;

      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await _location.getLocation();
      location = GeoPoint(_locationData.latitude!, _locationData.longitude!);
      hasGotLocation = true;
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
    }
  }
}
