import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 72, 192, 59)),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class GameMap extends StatelessWidget {
  const GameMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
