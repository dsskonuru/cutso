import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import 'mobile_form_provider.dart';

final registrationFormProvider =
    ChangeNotifierProvider((ref) => RegistrationFormNotifier());

class RegistrationFormNotifier extends ChangeNotifier {
  RegistrationFormNotifier();
  String? _name;
  String? _email;
  String? _mobileNo = container.read(mobileFormProvider).mobileNo;

  String? get name => _name;
  String? get email => _email;
  String? get mobileNo => _mobileNo;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setMobileNo(String mobileNo) {
    _mobileNo = mobileNo;
    notifyListeners();
  }
}
