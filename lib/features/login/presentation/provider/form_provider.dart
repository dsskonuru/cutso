import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';

class FormNotifier extends ChangeNotifier {
  String? _verificationId;
  String? _smsCode;
  bool? _codeSent;
  int? _phoneNo;

  String? _name;
  String? _email;
  String? _uid;
  String? _addressName;
  String? _addressLine;
  String? _addressLandmark;
  GeoPoint? _addressLocation;

  String? get verificationId => _verificationId;
  String? get smsCode => _smsCode;
  bool? get codeSent => _codeSent;
  int? get phoneNo => _phoneNo;

  String? get name => _name;
  String? get email => _email;
  String? get uid => _uid;
  String? get addressName => _addressName;
  String? get addressLine1 => _addressLine;
  String? get addressLandmark => _addressLandmark;
  GeoPoint? get location => _addressLocation;

  void setPhoneNo(int number) {
    _phoneNo = number;
    notifyListeners();
  }

  void setVerificationId(String id) {
    _verificationId = id;
    notifyListeners();
  }

  void setSmsCode(String code) {
    _smsCode = code;
    notifyListeners();
  }

  void setCodeSent(bool boolean) {
    _codeSent = boolean;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setUid(String? uid) {
    _uid = uid;
    notifyListeners();
  }

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

final formProvider = ChangeNotifierProvider((ref) => FormNotifier());
