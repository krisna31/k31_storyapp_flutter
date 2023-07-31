import 'package:flutter/material.dart';

import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.login),
        ),
      ),
      body: const Center(
        child: Text("hellow word"),
      ),
    );
  }
}
