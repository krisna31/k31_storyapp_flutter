import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:provider/provider.dart';

import '../../atom/image_with_network.dart';
import '../../enum/res_state.dart';
import '../../provider/story_provider.dart';

class StoryDetailScreen extends StatefulWidget {
  final String? storyId;
  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RouteHelper.toTitle(AppRoute.detailStory)),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, _) {
          if (storyProvider.state == ResState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (storyProvider.state == ResState.error) {
            return Center(
              child: Text(
                "Error: ${storyProvider.message}",
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                ImageWithNetwork(
                  url: storyProvider.detailStory.photoUrl,
                  cacheKey: storyProvider.detailStory.id,
                ),
                ListTile(
                  title: Text(
                    "Created by ${storyProvider.detailStory.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Description: ${storyProvider.detailStory.description}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Created At: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(storyProvider.detailStory.createdAt.toString()).toUtc())}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
