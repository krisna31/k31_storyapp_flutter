import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/story_provider.dart';

class MyPickGallery extends StatefulWidget {
  final StoryProvider storyProvider;
  const MyPickGallery({super.key, required this.storyProvider});

  @override
  State<MyPickGallery> createState() => _MyPickGalleryState();
}

class _MyPickGalleryState extends State<MyPickGallery> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (Platform.isMacOS || Platform.isLinux) return;

        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        widget.storyProvider.setImageFile(pickedFile);
        widget.storyProvider.setImagePath(pickedFile?.path);
      },
      child: const Text("Choose from gallery"),
    );
  }
}
