import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/components/user.dart';
import 'package:flutter_testing/meetsGame.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/profileScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'dart:async';
import 'package:ble_peripheral/ble_peripheral.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class PlazaScreen extends StatefulWidget {
  PlazaScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlazaScreenState();
}

class _PlazaScreenState extends State<PlazaScreen> {
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

  late final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();

  late PlazaGame gamePlaza;
  late MeetsGame gameAwait;

  late User usr1;
  late User usr2;
  late List users;
  late List friends = [];

  bool isZone = true;

  String nameAwaitUser = "name";

  @override
  void initState() {
    print("PlazaScreen initialized, triggering ble-init...");
    print("Check BLE permissions...");

    [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
      Permission.locationWhenInUse
    ].request().then((statuses) {
      print(statuses);

      // TODO: Handle permissions...
      //  print("PlazaScreen initialized, triggering ble-init...");
      Workmanager().registerOneOffTask('1', 'ble-init', inputData: {
        'name': 'Polkeng',
        'id': 1,
      });
      print("ble-init triggered");

      isInitialized = true;

      doScan();
      doAdvertise();
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    usr1 = User("Alvaro", "Play", "assets/images/enchantressICON.png");
    usr2 = User("Sara", "Hack", "assets/images/wizardICON.png");
    users = [usr1, usr2];

    gamePlaza = PlazaGame(user: user, friends: friends);
    gameAwait = MeetsGame(
        mapTiled: "Forum.tmx",
        users: users,
        callback: (val) => setState(() => showUser(val)));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My space!',
          textAlign: TextAlign.center,
          selectionColor: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                  );
                },
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Date list',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/dateList',
                  );
                },
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/dateList',
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Explore',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                icon: const Icon(Icons.public),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/explore',
                  );
                },
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/explore',
                );
              },
            ),
          ],
        ),
      ),
      body: GameWidget(game: isZone ? gamePlaza : gameAwait),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isZone = !isZone;
          });
        },
        foregroundColor: Colors.black,
        backgroundColor: isZone ? Colors.white : Colors.grey,
        shape: const CircleBorder(),
        child: isZone ? const Text("meets!") : const Text("my zone"),
      ),
    );
  }

  void showUser(String userName) async {
    User findUser(String id) =>
        users.firstWhere((user) => user.name == userName);
    User userShown = findUser(userName);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(userShown.name),
        content: Text(userShown.hobbies),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Add friend'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void handleNewDevice(DiscoveredDevice device) {
    String name = device.name;
    int id = 0;

    Uint8List payload = device.manufacturerData;
    id = payload[2] | (payload[3] << 8) | (payload[4] << 16) | (payload[5] << 24);

    print("Payload = $payload, payload0 = ${payload[0]}");

    //log("Discovered \"${device.name}\", Id: $id");

    friends.add(device.name);
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
