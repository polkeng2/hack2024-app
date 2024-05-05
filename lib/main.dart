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

late final ValueNotifier<String> token;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

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
