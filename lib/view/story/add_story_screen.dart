// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/provider/story_provider.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:provider/provider.dart';
import '../../atom/add_story_leading_icon.dart';
import '../../atom/builder_add_story.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({
    super.key,
  });

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(RouteHelper.toTitle(AppRoute.addStory)),
      leading: const AddStoryLeadingIcon(),
    );
  }

  Consumer _buildBody() {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, child) {
        return BuilderAddStory(
          formKey: _formKey,
          descriptionController: _descriptionController,
          storyProvider: storyProvider,
        );
      },
    );
  }

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  void _disposeAllController() {
    _descriptionController.dispose();
  }
}
