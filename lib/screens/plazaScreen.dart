import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/profileScreen.dart';
import 'package:workmanager/workmanager.dart';

class PlazaScreen extends StatefulWidget {
  PlazaScreen({ super.key });

  @override
  State<StatefulWidget> createState()  => _PlazaScreenState();
}

class _PlazaScreenState extends State<PlazaScreen> {
  PlazaGame game = PlazaGame();

  @override
  void initState() {
    print("PlazaScreen initialized, triggering ble-init...");
    Workmanager().registerOneOffTask('ble-init', 'ble-init', inputData: { 'name': 'Polkeng' } );
    print("ble-init triggered");
  }

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
      body: GameWidget(game: game),
    );
  }

}
