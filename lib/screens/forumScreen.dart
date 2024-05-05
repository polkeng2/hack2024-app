import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_testing/forumGame.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});
  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  var cityNames = [
    "Barcelona",
    "Madrid",
    "Sevilla",
    "Bilbao",
    "London",
    "Paris",
    "Japan"
  ];
  var activityNames = [
    "Party",
    "Nature",
    "Cinema",
    "Coffie",
    "Tourism",
  ];
  var groupNames = [
    "Manuel",
    "Cesc",
    "Oriol",
  ];

  late ForumGame gameForum;
  late ForumGame gameCity;
  late ForumGame gameActivity;
  String mapSelection = "forum";

  @override
  Widget build(BuildContext context) {
    gameForum = ForumGame(
        type: "forum",
        mapTiled: "Forum.tmx",
        actorsName: cityNames,
        callback: (val) => setState(() => mapSelection = val));
    gameCity = ForumGame(
        type: "city",
        mapTiled: "Forum.tmx",
        actorsName: activityNames,
        callback: (val) => setState(() => mapSelection = val));
    gameActivity = ForumGame(
        type: "activity",
        mapTiled: "Forum.tmx",
        actorsName: groupNames,
        callback: (val) => setState(() => mapSelection = val));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mapSelection,
          textAlign: TextAlign.center,
          selectionColor: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      body: _buildBody(mapSelection),
    );
  }

  Widget _buildBody(String id) {
    switch (id) {
      case "forum":
        return GameWidget(game: gameForum);

      case "city":
        return GameWidget(game: gameCity);

      case "activity":
        return GameWidget(game: gameActivity);

      default:
        return const Text("game not started");
    }
  }
}
