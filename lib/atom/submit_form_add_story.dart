// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../enum/res_state.dart';
import '../provider/story_provider.dart';

class SubmitFormAddStory extends StatelessWidget {
  final StoryProvider storyProvider;
  const SubmitFormAddStory({
    super.key,
    required TextEditingController descriptionController,
    required this.storyProvider,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final imagePath = storyProvider.imagePath;
        final imageFile = storyProvider.imageFile;
        if (imagePath == null || imageFile == null) return;

        final fileName = imageFile.name;
        final bytes = await imageFile.readAsBytes();

        final newBytes = await storyProvider.compressImage(bytes);

        await storyProvider.addStory(
          _descriptionController.text,
          newBytes,
          fileName,
        );

        if (storyProvider.state == ResState.hasData) {
          storyProvider.setImageFile(null);
          storyProvider.setImagePath(null);
          _descriptionController.clear();
          storyProvider.getAllStory();
          context.go('/');
        }

        if (storyProvider.state == ResState.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(storyProvider.message)),
          );
        }
      },
      child: storyProvider.state == ResState.loading
          ? const CircularProgressIndicator(
              color: Color.fromARGB(255, 123, 22, 213),
            )
          : const Text("Upload Story"),
    );
  }
}
