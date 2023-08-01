import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/data/preferences/preference_helper.dart';
import 'package:k31_storyapp_flutter/provider/auth_provider.dart';
import 'package:k31_storyapp_flutter/provider/story_provider.dart';
import 'package:k31_storyapp_flutter/routes/my_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';

void main() => configureMain();

void configureMain() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const EntryApp());
}

class EntryApp extends StatelessWidget {
  const EntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = AuthProvider(
      apiService: ApiService(),
      preferenceHelper: PreferencesHelper(
        sharedPreferences: SharedPreferences.getInstance(),
      ),
    );
    final myRoute = MyRoute(authProvider: authProvider);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => authProvider,
        ),
        ChangeNotifierProvider<StoryProvider>(
          create: (_) => StoryProvider(
            preferenceHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
            apiService: ApiService(),
          ),
        )
      ],
      child: MaterialApp.router(
        routerConfig: myRoute.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
