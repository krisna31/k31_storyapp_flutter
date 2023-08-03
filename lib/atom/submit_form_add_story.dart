import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../enum/res_state.dart';
import '../provider/story_provider.dart';

class SubmitFormAddStory extends StatelessWidget {
  final StoryProvider storyProvider;
  final LatLng? latLng;
  final GlobalKey<FormState> formKey;
  const SubmitFormAddStory({
    super.key,
    required TextEditingController descriptionController,
    required this.storyProvider,
    this.latLng,
    required this.formKey,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final imagePath = storyProvider.imagePath;
        final imageFile = storyProvider.imageFile;
        if (imagePath == null || imageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Image is required",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
          return;
        }

        if (!formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Description is required",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
          return;
        }

        if (latLng == null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Are You Sure Submit Without Location?"),
                content: const Text(
                  "You can add location by long press on map",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("Okay I will add the location"),
                  ),
                  TextButton(
                    onPressed: () =>
                        _submitTheStory(imageFile, context, null, null),
                    child: const Text(
                      "Yes, Add the story",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return;
        }

        await _submitTheStory(
          imageFile,
          context,
          latLng!.latitude,
          latLng!.longitude,
        );
      },
      child: storyProvider.state == ResState.loading
          ? const CircularProgressIndicator(
              color: Color.fromARGB(255, 123, 22, 213),
            )
          : const Text("Upload Story"),
    );
  }

  Future<void> _submitTheStory(
    XFile imageFile,
    BuildContext context,
    double? lat,
    double? long,
  ) async {
    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes = await storyProvider.compressImage(bytes);

    await storyProvider.addStory(
      _descriptionController.text,
      newBytes,
      fileName,
      lat,
      long,
    );

    if (storyProvider.state == ResState.hasData) {
      storyProvider.setImageFile(null);
      storyProvider.setImagePath(null);
      _descriptionController.clear();
      storyProvider.getAllStory();
      // ignore: use_build_context_synchronously
      context.go('/');
    }

    if (storyProvider.state == ResState.error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(storyProvider.message)),
      );
    }
  }
}
