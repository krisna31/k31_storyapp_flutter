import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../provider/story_provider.dart';

class AddStoryHelper {
  static Widget showimg(StoryProvider storyProvider) {
    return kIsWeb
        ? Image.network(storyProvider.imagePath.toString())
        : Image.file(File(storyProvider.imagePath.toString()));
  }
}
