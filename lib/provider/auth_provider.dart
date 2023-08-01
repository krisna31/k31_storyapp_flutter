import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/data/api/api_service.dart';
import 'package:k31_storyapp_flutter/data/preferences/preference_helper.dart';
import 'package:k31_storyapp_flutter/enum/res_state.dart';

class AuthProvider extends ChangeNotifier {
  final PreferencesHelper preferenceHelper;
  final ApiService apiService;

  AuthProvider({
    required this.preferenceHelper,
    required this.apiService,
  }) {
    checkLogin();
  }

  String _message = '';

  /// ! Dont forget to change this for spalash screen
  // bool _isSplash = true;
  bool _isLogin = false;
  bool _isSplash = false;
  ResState _state = ResState.initial;

  bool get isLogin => _isLogin;
  ResState get state => _state;
  String get message => _message;
  bool get isSplash => _isSplash;

  void initAuthProvider() async {
    await Future.delayed(const Duration(seconds: 2));
    _isSplash = false;
    notifyListeners();
  }

  void checkLogin() async {
    if (await preferenceHelper.getToken != '') {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
    notifyListeners();
  }

  void login(String email, String password) async {
    try {
      _state = ResState.loading;
      notifyListeners();
      final loginData = await apiService.login(email, password);
      _state = ResState.hasData;
      preferenceHelper.setToken(loginData.loginResult.token);
      preferenceHelper.setName(loginData.loginResult.name);
      _isLogin = true;
      notifyListeners();
    } catch (e) {
      _state = ResState.error;
      _message = e.toString().replaceFirst('Exception:', '');
      notifyListeners();
    }
  }

  void register(String name, String email, String password) async {
    try {
      _state = ResState.loading;
      notifyListeners();
      await apiService.register(name, email, password);
      _state = ResState.hasData;
      notifyListeners();
    } catch (e) {
      _state = ResState.error;
      _message = e.toString().replaceFirst('Exception:', '');
      notifyListeners();
    }
  }

  void logout() async {
    _state = ResState.loading;
    await preferenceHelper.setToken('');
    await preferenceHelper.setName('');
    _isLogin = false;
    _state = ResState.hasData;
    notifyListeners();
  }
}
