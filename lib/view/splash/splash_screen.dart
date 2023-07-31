import 'package:flutter/material.dart';

import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.splash),
        ),
      ),
      body: const Center(
        child: Text("hellow word"),
      ),
    );
  }
}
