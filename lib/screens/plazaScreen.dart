import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/profileScreen.dart';

class PlazaScreen extends StatelessWidget {
  PlazaScreen({super.key});

  PlazaGame game = PlazaGame();

  @override
  Widget build(BuildContext context) {
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
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                );
              },
            ),
            ListTile(
              title: const Text('Set a date'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/setDate',
                );
              },
            ),
            ListTile(
              title: const Text('Date list'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/dateList',
                );
              },
            ),
            ListTile(
              title: const Text('Forum'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/forum',
                );
              },
            ),
          ],
        ),
      ),
      body: GameWidget(game: game),
    );
  }
}
