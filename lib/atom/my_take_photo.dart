import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/story_provider.dart';

class MyTakePhoto extends StatelessWidget {
  final StoryProvider storyProvider;
  const MyTakePhoto({super.key, required this.storyProvider});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (Platform.isAndroid || Platform.isIOS) {
          return ElevatedButton(
            onPressed: () async {
              if (!(Platform.isAndroid || Platform.isIOS)) {
                return;
              }

              final file =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              storyProvider.setImageFile(file);
              storyProvider.setImagePath(file?.path);
            },
            child: const Text("Take a photo"),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
