import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';

class StoryDetailScreen extends StatelessWidget {
  final String? storyId;
  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RouteHelper.toTitle(AppRoute.detailStory)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: Text('$storyId Go back to the Home screen'),
        ),
      ),
    );
  }
}
