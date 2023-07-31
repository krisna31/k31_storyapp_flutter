import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  PreferencesHelper({required this.sharedPreferences});
  static const authKey = 'AUTH';

  Future<bool> get isLogin async {
    final prefs = await sharedPreferences;
    return prefs.getBool(authKey) ?? false;
  }

  void setLogin(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(authKey, value);
  }
}
