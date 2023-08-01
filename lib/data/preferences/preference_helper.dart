import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  PreferencesHelper({required this.sharedPreferences});
  static const tokenKey = 'AUTH-TOKEN';
  static const nameKey = 'AUTH-NAME';

  Future<String> get name async {
    final prefs = await sharedPreferences;
    return prefs.getString(nameKey) ?? '';
  }

  Future<void> setName(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(nameKey, value);
  }

  Future<bool> get isLogin async {
    final prefs = await sharedPreferences;
    return prefs.getBool(tokenKey) ?? false;
  }

  Future<String> get getToken async {
    final prefs = await sharedPreferences;
    return prefs.getString(tokenKey) ?? '';
  }

  Future<void> setToken(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(tokenKey, value);
  }
}
