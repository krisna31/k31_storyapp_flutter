import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../enum/res_state.dart';
import '../provider/story_provider.dart';
import 'image_with_network.dart';

class StoriesBody extends StatelessWidget {
  const StoriesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
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
                  storyProvider.getDetailStory(storyProvider.stories[index].id);
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
    );
  }
}
