import 'package:flutter/material.dart';

import '../provider/story_provider.dart';

class ShowErrorText extends StatelessWidget {
  final StoryProvider storyProvider;
  const ShowErrorText({super.key, required this.storyProvider});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Error: ${storyProvider.message}",
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
