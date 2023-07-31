import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/routes/my_route.dart';
import 'package:url_strategy/url_strategy.dart';

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
    return MaterialApp.router(
      routerConfig: MyRoute().router,
    );
  }
}
