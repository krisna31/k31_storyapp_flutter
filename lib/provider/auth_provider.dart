import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/data/preferences/preference_helper.dart';
import 'package:k31_storyapp_flutter/enum/res_state.dart';

class AuthProvider extends ChangeNotifier {
  final PreferencesHelper preferenceHelper;

  AuthProvider({required this.preferenceHelper});

  bool _isLogin = false;
  late ResState _state;

  bool get isLogin => _isLogin;
  ResState get state => _state;

  void login() {
    preferenceHelper.setLogin(true);
    _isLogin = true;
    notifyListeners();
  }

  void logout() {
    preferenceHelper.setLogin(false);
    _isLogin = false;
    notifyListeners();
  }

  void checkLogin() async {
    _isLogin = await preferenceHelper.isLogin;
    notifyListeners();
  }
}
