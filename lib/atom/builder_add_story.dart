import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/atom/submit_form_add_story.dart';

import '../provider/story_provider.dart';
import '../util/add_story_helper.dart';
import 'deskripsi_input_add_story.dart';
import 'my_pick_gallery.dart';
import 'my_take_photo.dart';

class BuilderAddStory extends StatelessWidget {
  final StoryProvider storyProvider;
  const BuilderAddStory({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController descriptionController,
    required this.storyProvider,
  })  : _formKey = formKey,
        _descriptionController = descriptionController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            storyProvider.imagePath == null
                ? const Center(
                    child: Icon(
                      Icons.image,
                      size: 100,
                    ),
                  )
                : AddStoryHelper.showimg(storyProvider),
            const SizedBox(height: 20),
            DeskripsiInputAddStory(
              descriptionController: _descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTakePhoto(
              storyProvider: storyProvider,
            ),
            const SizedBox(height: 20),
            MyPickGallery(
              storyProvider: storyProvider,
            ),
            const SizedBox(height: 20),
            SubmitFormAddStory(
              descriptionController: _descriptionController,
              storyProvider: storyProvider,
            ),
          ],
        ),
      ),
    );
  }
}
