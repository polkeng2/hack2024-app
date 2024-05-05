import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/dateListScreen.dart';
import 'package:flutter_testing/screens/dateScreen.dart';
import 'package:flutter_testing/screens/forumScreen.dart';
import 'package:flutter_testing/screens/plazaScreen.dart';
import 'package:flutter_testing/screens/profileScreen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:workmanager/workmanager.dart';

late final ValueNotifier<String> token;

void wmDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case 'ble-init':
        // bluetooth init...
        if (inputData == null) {
          print("WM (ble-init): inputData cannot be null!");
          return Future.value(false);
        }

        if (!inputData.containsKey("name")) {
          print("WM (ble-init): Required parameter 'name'");
          return Future.value(false);
        }

        String username = inputData["name"];
        print("WM (ble-init): Initialize BLE with name = $username");
        
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
  await initLocalStorage();
  Workmanager().initialize(wmDispatcher);

  token = ValueNotifier<String>(localStorage.getItem('token') ?? '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: switch (token.value == '') {
        true => PlazaScreen(),
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
