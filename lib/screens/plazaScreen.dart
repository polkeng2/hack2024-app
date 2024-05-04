import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';

class PlazaScreen extends StatelessWidget {
  PlazaScreen({super.key});

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
