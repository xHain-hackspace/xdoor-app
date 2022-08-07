import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum DoorAction { open, close }

class Door {
  static const _duration = Duration(seconds: 5);

  static Future open() async {
    debugPrint("Opening...");
    return Future.delayed(_duration);
  }

  static Future close() async {
    debugPrint("Closing...");
    return Future.delayed(_duration);
  }
}
