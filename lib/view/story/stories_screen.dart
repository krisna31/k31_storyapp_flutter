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
    List<Widget> listOfActions = [
      InkWell(
        onTap: () {
          // show toast for todo feature
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This feature is not available yet"),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  "Maps",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.map),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure to logout?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      final authProvider = context.read<AuthProvider>();
                      authProvider.logout();
                    },
                    child: const Text("Logout"),
                  ),
                ],
              );
            },
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.exit_to_app),
            ],
          ),
        ),
      ),
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
