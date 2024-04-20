import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const prefToken = "token";
  static const prefUserId = "userId";

  UserPreference();

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefToken);
  }

  Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(prefUserId);
  }

  setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefToken, value);
  }

  setUserId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(prefUserId, value);
  }
}
