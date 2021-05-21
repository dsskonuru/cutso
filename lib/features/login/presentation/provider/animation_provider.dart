import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/sign_in_widgets.dart';

class AnimateNotifier extends ChangeNotifier {
  bool _animate = false;
  double _logoHeight = 0;
  SignInPageState _state = SignInPageState.MOBILE_NUMBER_FORM;

  SignInPageState get state => _state;
  bool get animate => _animate;
  double get logoHeight => _logoHeight;

  void setAnimation(bool b) {
    _animate = b;
    _logoHeight = _animate ? -200 : 0;
    notifyListeners();
  }

  void setLoginState(SignInPageState state) {
    _state = state;
    notifyListeners();
  }
}

final animationProvider = ChangeNotifierProvider((ref) => AnimateNotifier());