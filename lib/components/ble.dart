import 'dart:async';

import 'package:ble_peripheral/ble_peripheral.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class Ble {
  static const APP_UUID = "bf27730d-860a-4e09-889c-2d8b6a9e0fe7";
  static const APP_UUID2 = "00002A18-0000-1000-8000-00805F9B34FB";

  /* User data (shared with nearby people) */
  late String name;
  late int id;

  late final flutterReactiveBle = FlutterReactiveBle();

  Ble( { required this.name, required this.id });


  void log(String text) => print("[ble] ${text}");
}