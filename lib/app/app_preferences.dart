import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences sharedPreferences;

  AppPreferences({
    required this.sharedPreferences,
  });

  //login

  Future<void> setUserLoggedIn() async {
    sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}
