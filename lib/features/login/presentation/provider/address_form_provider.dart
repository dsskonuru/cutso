import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import '../../../../core/providers/firebase_provider.dart';
import '../../../../main.dart';
import '../../data/models/user.dart';

final addressFormProvider =
    ChangeNotifierProvider((ref) => AddressFormNotifier());

class AddressFormNotifier extends ChangeNotifier {
  String? _addressName;
  String? _addressLine;
  String? _addressLandmark;
  GeoPoint? _addressLocation;

  String? get addressName => _addressName;
  String? get addressLine => _addressLine;
  String? get addressLandmark => _addressLandmark;
  GeoPoint? get location => _addressLocation;

  void setAddressName(String? addressName) {
    _addressName = addressName;
    notifyListeners();
  }

  void setAddressLine(String? addressLine) {
    _addressLine = addressLine;
    notifyListeners();
  }

  void setAddressLandmark(String? addressLandmark) {
    _addressLandmark = addressLandmark;
    notifyListeners();
  }

  void setLocation(GeoPoint? addressLocation) {
    _addressLocation = addressLocation;
    notifyListeners();
  }

  Address getAddress() {
    return Address(
      name: _addressName!,
      location: _addressLocation!,
      line: _addressLine!,
      landmark: _addressLandmark!,
    );
  }

  Future<void> getLocation() async {
    try {
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
      setLocation(
        GeoPoint(_locationData.latitude!, _locationData.longitude!),
      );
    } catch (error, stackTrace) {
      container.read(crashlyticsProvider).recordError(error, stackTrace);
    }
  }
}
