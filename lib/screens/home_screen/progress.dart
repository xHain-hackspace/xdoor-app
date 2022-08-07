import 'package:flutter/foundation.dart';

class Progress with ChangeNotifier {
  bool _inProgress = false;

  bool get() => _inProgress;
  void set(bool val) {
    _inProgress = val;
    notifyListeners();
  }
}
