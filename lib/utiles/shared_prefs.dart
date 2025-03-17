import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getUserLoggedIn() => _prefs.getBool('isLoggedIn') ?? false;
  static Future<void> setUserLoggedIn(bool value) => _prefs.setBool('isLoggedIn', value);
}