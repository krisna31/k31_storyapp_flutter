import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../atom/add_fab.dart';
import '../../atom/stories_body.dart';
import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    List<IconButton> listOfActions = [
      IconButton(
        onPressed: () {
          final authProvider = context.read<AuthProvider>();
          authProvider.logout();
        },
        icon: const Icon(
          Icons.exit_to_app,
        ),
        tooltip: "Exit The App",
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.home),
        ),
        actions: listOfActions,
      ),
      floatingActionButton: const AddFAB(),
      body: const StoriesBody(),
    );
  }
}
