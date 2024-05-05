import 'dart:async';

import 'package:ble_peripheral/ble_peripheral.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

class Ble {
  static const APP_UUID = "bf27730d-860a-4e09-889c-2d8b6a9e0fe7";
  static const APP_UUID2 = "00002A18-0000-1000-8000-00805F9B34FB";

  static bool isInitialized = false;
  static bool isAdvertising = false;
  static bool isScanning = false;

  /* User data (shared with nearby people) */
  late String name;
  late int id;

  /* List of discovered devices, should also be synced with backend */
  Map<String, void> discoveredDevices = {};

  late final FlutterReactiveBle flutterReactiveBle;

  Ble( { required this.name, required this.id }) {
    flutterReactiveBle = FlutterReactiveBle();
  }

  void initialize() async {
    if (isInitialized) {
      return;
    }

    isInitialized = true;

    doScan();
    doAdvertise();
  }

  void handleNewDevice(DiscoveredDevice device) {
    log("Discovered \"${device.name}\" (${device.id})");
    // Notify
  }

  void doScan() async {
    if (isScanning) {
      return;
    }

    isScanning = true;

    // Check permissions
    log("Scanning nearby devices...");

    flutterReactiveBle.scanForDevices(withServices: [ Uuid.parse(APP_UUID) ]).listen((device) {
      // Skip already discovered devices
      if (discoveredDevices.containsKey(device.id)) {
        return;
      }

      discoveredDevices[device.id] = ();
      handleNewDevice(device);
    });
  }

  void doAdvertise() async {
    if (isAdvertising) {
      return;
    }

    isAdvertising = true;

    log("Initializing BlePeripheral...");
    BlePeripheral.initialize();

    log("Adding services...");
    var notificationControlDescriptor = BleDescriptor(
      uuid: "00002908-0000-1000-8000-00805F9B34FB",
      value: Uint8List.fromList([0, 1]),
      permissions: [
        AttributePermissions.readable.index,
        AttributePermissions.writeable.index
      ],
    );

    await BlePeripheral.addService(
      BleService(
        uuid: APP_UUID,
        primary: true,
        characteristics: [
          BleCharacteristic(
            uuid: APP_UUID2,
            properties: [
              CharacteristicProperties.read.index,
              CharacteristicProperties.notify.index,
              CharacteristicProperties.write.index,
            ],
            descriptors: [notificationControlDescriptor],
            value: null,
            permissions: [
              AttributePermissions.readable.index,
              AttributePermissions.writeable.index
            ],
          ),
        ],
      ),
    );

    log("Building payload...");

    // Assume int is 32 bit...
    Uint8List payload = Uint8List(4);

    payload[0] = id & 0xFF;
    payload[1] = (id >> 8) & 0xFF;
    payload[2] = (id >> 16) & 0xFF;
    payload[3] = (id >> 24) & 0xFF;

    var manufacturerData = ManufacturerData(
      manufacturerId: 0xFF,
      data: payload,
    );

    log("Payload: $payload");
    log("Advertising...");

    await BlePeripheral.startAdvertising(
      services: [ APP_UUID ],
      localName: name,
      manufacturerData: manufacturerData,
      addManufacturerDataInScanResponse: true,
    );
  }

  void log(String text) => print("[ble] ${text}");
}