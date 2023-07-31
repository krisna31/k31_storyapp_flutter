import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.home),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/11243'),
          child: const Text('Go to the Details screen'),
        ),
      ),
    );
  }
}
