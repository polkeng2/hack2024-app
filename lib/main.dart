import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/classes/userToken.dart';
import 'package:flutter_testing/components/ble.dart';
import 'package:flutter_testing/components/user.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/dateListScreen.dart';
import 'package:flutter_testing/screens/dateScreen.dart';
import 'package:flutter_testing/screens/forumScreen.dart';
import 'package:flutter_testing/screens/plazaScreen.dart';
import 'package:flutter_testing/screens/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool bleInitialized = false;
void wmDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case 'ble-init':
        if (bleInitialized) {
          return Future.value(true);
        }

        bleInitialized = true;

        // bluetooth init...
        if (inputData == null) {
          print("WM (ble-init): inputData cannot be null!");
          return Future.value(false);
        }

        if (!inputData.containsKey("name")) {
          print("WM (ble-init): Required parameter 'name'");
          return Future.value(false);
        }

        String name = inputData["name"];
        int id = inputData["id"];
        print("WM (ble-init): Initialize BLE with name = $name, id = $id");

        Ble(name: name, id: id).initialize();
        await Future.delayed(const Duration(days: 1));
        break;
      default:
        print("WM: Undefined task!");
        return Future.value(false);
    }

    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().cancelAll();
  await Workmanager().initialize(wmDispatcher);

  await UserToken.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          User("Name", "Hobbies", "assets/images/archerICON.png"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = UserToken.isFirstTime();

  //bool token = _prefs.getString('token');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect with others!',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleSpacing: 32.0,
        ),
        useMaterial3: true,
      ),
      home: switch (firstTime) {
        true => const ProfileScreen(),
        false => PlazaScreen(),
      },
      routes: {
        '/plaza': (context) => PlazaScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/dateList': (context) => const DateListScreen(),
        '/explore': (context) => const ForumScreen(),
      },
    );
  }
}
