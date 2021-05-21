import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormNotifier extends ChangeNotifier {
  int? _phoneNo;
  String? _verificationId;
  String? _smsCode;
  bool? _codeSent;

  String? _name;
  String? _email;
  String? _uid;

  int? get phoneNo => _phoneNo;
  String? get verificationId => _verificationId;
  String? get smsCode => _smsCode;
  bool? get codeSent => _codeSent;

  String? get name => _name;
  String? get email => _email;
  String? get uid => _uid;

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
}

final formProvider = ChangeNotifierProvider((ref) => FormNotifier());
