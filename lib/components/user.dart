import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  late String name = "name";
  late String hobbies = "hobbies";
  late String avatarSprite = "assets/images/archerICON.png";

  set nameUser(String newNameUser)
  {
    name = newNameUser;
    notifyListeners();
  }
  set hobbiesUser(String newHobbiesUser)
  {
    name = newHobbiesUser;
    notifyListeners();
  }
  set avatarUser(String newAvatarUser)
  {
    name = newAvatarUser;
    notifyListeners();
  }

  void setUserName(String str) { name = str; notifyListeners(); }
  void setUserHobbies(String str) { hobbies = str; notifyListeners(); }
  void setUserAvatar(String str) { avatarSprite = str; notifyListeners(); }

  String getUserName() { return name; }
  String getUserHobbies() { return hobbies; }
  String getUserAvatar() { return avatarSprite; }

}