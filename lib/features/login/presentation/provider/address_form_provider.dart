import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/address.dart';

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
}
