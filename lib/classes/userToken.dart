import 'package:shared_preferences/shared_preferences.dart';

class UserToken {
  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future setToken(String token) async {
    await _prefs.setString('token', token);
  }

  static bool isFirstTime() {
    bool result = !_prefs.containsKey('token');
    print("The result is here !!! $result");
    return result;
  }

  static Future removeToken() async {
    await _prefs.remove('token');
    print("Token removed!");
  }
}
