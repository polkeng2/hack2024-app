import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/plazaScreen.dart';
import 'package:flutter_testing/screens/profileScreen.dart';

void main() {
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
      home: const ProfileScreen(),
      routes: {
        '/plaza': (context) => PlazaScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
