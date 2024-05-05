import 'dart:math';

import 'package:flutter/foundation.dart';

List avatarNameFiles = [
    "assets/images/archerICON.png",
    "assets/images/enchantressICON.png",
    "assets/images/knightICON.png",
    "assets/images/wizardICON.png",
  ];

class User extends ChangeNotifier {
  late String id = "id";
  late String token = "";
  late String name = "name";
  late String hobbies = "hobbies";
  late String avatarSprite = "assets/images/archerICON.png";
  late List friends = [];
  late List meets = [];
  late int dateId = 0;

  User(String nUser, String hUser, String aUser) {
    name = nUser;
    hobbies = hUser;
    avatarSprite = aUser;
  }

  set nameUser(String newNameUser) {
    name = newNameUser;
    notifyListeners();
  }

  set hobbiesUser(String newHobbiesUser) {
    name = newHobbiesUser;
    notifyListeners();
  }

  set avatarUser(String newAvatarUser) {
    name = newAvatarUser;
    notifyListeners();
  }

  void setUserName(String str) {
    name = str;
    notifyListeners();
  }

  void setUserHobbies(String str) {
    hobbies = str;
    notifyListeners();
  }

  void setUserAvatar(String str) {
    avatarSprite = str;
    notifyListeners();
  }

  void addMeet(String name, String hobbies, String avatar) {
    meets.add(User(name, hobbies, avatar));
  }

  void addFriend(String name, String hobbies, String avatar) {
    friends.add(User(name, hobbies, avatar));
  }

  void addFriendName(String name) {
    friends.add(User(name, "play and dance", avatarNameFiles[Random().nextInt(4)]));
  }

  String getUserName() {
    return name;
  }

  String getUserHobbies() {
    return hobbies;
  }

  String getUserAvatar() {
    return avatarSprite;
  }
}
