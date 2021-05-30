import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimateNotifier extends ChangeNotifier {
  bool _animate = false;
  double _logoHeight = 0;

  bool get animate => _animate;
  double get logoHeight => _logoHeight;

  void setAnimation(bool b) {
    _animate = b;
    _logoHeight = _animate ? -200 : 0;
    notifyListeners();
  }
}

final animationProvider = ChangeNotifierProvider((ref) => AnimateNotifier());
