import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/components/user.dart';
import 'package:flutter_testing/meetsGame.dart';
import 'package:flutter_testing/plazaGame.dart';
import 'package:flutter_testing/screens/profileScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

class PlazaScreen extends StatefulWidget {
  PlazaScreen({ super.key });

  @override
  State<StatefulWidget> createState()  => _PlazaScreenState();
}

class _PlazaScreenState extends State<PlazaScreen> {
  late PlazaGame gamePlaza;
  late MeetsGame gameAwait;

  late User usr1;
  late User usr2;
  late List users;

  bool isZone = true;

  String nameAwaitUser = "name";

  @override
  void initState() {
    print("PlazaScreen initialized, triggering ble-init...");
    print("Check BLE permissions...");

    [ Permission.bluetooth, Permission.bluetoothScan, Permission.bluetoothConnect, Permission.bluetoothAdvertise, Permission.location, Permission.locationWhenInUse ].request().then((statuses) {
      print(statuses);

      // TODO: Handle permissions...
      //  print("PlazaScreen initialized, triggering ble-init...");
      Workmanager().registerOneOffTask('1', 'ble-init', inputData: { 'name': 'Polkeng', 'id': 1, } );
      print("ble-init triggered");
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    usr1 = User("Alvaro", "assets/images/enchantressICON.png", "Play");
    usr2 = User("Sara", "assets/images/wizardICON.png", "Hack");
    users = [ usr1, usr2 ];

    gamePlaza = PlazaGame(user: user);
    gameAwait = MeetsGame(mapTiled: "Forum.tmx", users: users, callback: (val) => setState(() => showUser(val)));

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
      body: GameWidget(game: isZone? gamePlaza : gameAwait),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isZone = !isZone;
          });
        },
        foregroundColor: Colors.black,
        backgroundColor: isZone? Colors.white : Colors.grey,
        shape: const CircleBorder(),
        child: isZone? const Text("meets!") : const Text("my zone"),
      ),
    );
  }

  void showUser(String userName) async {
    User findUser(String id) => users.firstWhere((user) => user.name == userName);
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

}
