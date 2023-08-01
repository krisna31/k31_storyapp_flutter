import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k31_storyapp_flutter/atom/image_with_network.dart';
import 'package:k31_storyapp_flutter/provider/story_provider.dart';
import 'package:provider/provider.dart';

import '../../enum/res_state.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.home),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(RouteHelper.toPath(AppRoute.addStory)),
        child: const Icon(Icons.add),
      ),
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, _) {
          if (storyProvider.state == ResState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: storyProvider.stories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    storyProvider
                        .getDetailStory(storyProvider.stories[index].id);
                    context.go(
                      '/${storyProvider.stories[index].id}',
                    );
                  },
                  child: Column(
                    children: [
                      ImageWithNetwork(
                        url: storyProvider.stories[index].photoUrl,
                        cacheKey: storyProvider.stories[index].id,
                      ),
                      ListTile(
                        title: Text(
                          storyProvider.stories[index].name,
                        ),
                        subtitle: Text(
                          storyProvider.stories[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
