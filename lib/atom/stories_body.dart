import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../enum/res_state.dart';
import '../provider/story_provider.dart';
import 'image_with_network.dart';

class StoriesBody extends StatefulWidget {
  const StoriesBody({
    super.key,
  });

  @override
  State<StoriesBody> createState() => _StoriesBodyState();
}

class _StoriesBodyState extends State<StoriesBody> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // log(scrollController.position.pixels.toString());
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        final storyProvider =
            Provider.of<StoryProvider>(context, listen: false);
        if (storyProvider.pageItems != null) {
          storyProvider.getAllStory();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, _) {
        if (storyProvider.state == ResState.loading &&
            storyProvider.pageItems == 1) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (storyProvider.state == ResState.noData) {
          return const Center(
            child: Text("No Data"),
          );
        } else if (storyProvider.state == ResState.error) {
          return Center(
            child: Text(
              "Error : ${storyProvider.message}",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return ListView.builder(
            controller: scrollController,
            itemCount: getItemCount(storyProvider),
            itemBuilder: (context, index) {
              if (isBottomPage(index, storyProvider)) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return InkWell(
                onTap: () {
                  _goToDetailPage(storyProvider, index, context);
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

  void _goToDetailPage(
      StoryProvider storyProvider, int index, BuildContext context) {
    storyProvider.getDetailStory(storyProvider.stories[index].id);
    context.go(
      '/${storyProvider.stories[index].id}',
    );
  }

  bool isBottomPage(int index, StoryProvider storyProvider) {
    return index == storyProvider.stories.length &&
        storyProvider.pageItems != null;
  }

  int getItemCount(StoryProvider storyProvider) {
    return storyProvider.stories.length +
        (storyProvider.pageItems != null ? 1 : 0);
  }
}
