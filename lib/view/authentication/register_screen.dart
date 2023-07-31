import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';

import '../../routes/app_route.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.register),
        ),
      ),
      body: const Center(
        child: Text("hellow world"),
      ),
    );
  }
}
