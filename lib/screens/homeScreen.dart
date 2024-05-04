import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';

/* class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlazaGame game = PlazaGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My space'),
        backgroundColor: Colors.green,
      ),
      body: GameWidget(game: game),
    );
  }
} */

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  PlazaGame game = PlazaGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My space!'),
        backgroundColor: Colors.green,
      ),
      body: GameWidget(game: game),
    );
  }
}
