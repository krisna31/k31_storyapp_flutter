// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k31_storyapp_flutter/enum/res_state.dart';
import 'package:k31_storyapp_flutter/provider/story_provider.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:provider/provider.dart';
import '../../atom/deskripsi_input_add_story.dart';

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
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RouteHelper.toTitle(AppRoute.detailStory)),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 16, 31, 16),
        child: Consumer<StoryProvider>(
          builder: (context, storyProvider, child) {
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
                        : showimg(storyProvider),
                    const SizedBox(height: 20),
                    DeskripsiInputAddStory(
                      descriptionController: _descriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(
                      builder: (context) {
                        if (Platform.isAndroid || Platform.isIOS) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (!(Platform.isAndroid || Platform.isIOS)) {
                                return;
                              }

                              final file = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);

                              storyProvider.setImageFile(file);
                              storyProvider.setImagePath(file?.path);
                            },
                            child: const Text("Take a photo"),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (Platform.isMacOS || Platform.isLinux) return;

                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );

                        storyProvider.setImageFile(pickedFile);
                        storyProvider.setImagePath(pickedFile?.path);
                      },
                      child: const Text("Choose from gallery"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final imagePath = storyProvider.imagePath;
                        final imageFile = storyProvider.imageFile;
                        if (imagePath == null || imageFile == null) return;

                        final fileName = imageFile.name;
                        final bytes = await imageFile.readAsBytes();

                        final newBytes =
                            await storyProvider.compressImage(bytes);

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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget showimg(StoryProvider storyProvider) {
    return kIsWeb
        ? Image.network(storyProvider.imagePath.toString())
        : Image.file(File(storyProvider.imagePath.toString()));
  }
}
