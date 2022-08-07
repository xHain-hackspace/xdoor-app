import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ConnectedToWifi with ChangeNotifier {
  static const List<String> _allowedWifiNames = ['xHain', 'xHain_5G'];
  static const oneSec = Duration(seconds: 1);

  ConnectedToWifi() {
    Timer.periodic(oneSec, (Timer t) => _check());
  }

  bool _connected = false;
  final _info = NetworkInfo();

  bool get() {
    return _connected;
  }

  _check() async {
    final wifiName = await Future<String>.delayed(
      const Duration(milliseconds: 20),
      () {
        return 'xHain';
      },
    );
    final old = _connected;
    _connected = _allowedWifiNames.contains(wifiName);
    if (old != _connected) {
      notifyListeners();
    }
  }
}
