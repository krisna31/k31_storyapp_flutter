import 'package:flutter/material.dart';
import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class ErrorScreen extends StatelessWidget {
  final String? error;
  const ErrorScreen({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.error),
        ),
      ),
      body: const Center(
        child: Text("Error Screen"),
      ),
    );
  }
}
