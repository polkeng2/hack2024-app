import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar creator!'),
        backgroundColor: Colors.green,
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Image(image: AssetImage('profile_icon.png')),
          ),
          Text('enter name:'),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(),
          ),
        ],
      ),
    );
  }
}
