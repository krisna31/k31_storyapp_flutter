import 'package:flutter/material.dart';

class DeskripsiInputAddStory extends StatelessWidget {
  final TextEditingController descriptionController;
  const DeskripsiInputAddStory(
      {super.key, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 3,
        decoration: const InputDecoration(
          hintText: "Description",
        ),
        validator: _validateDescription,
        controller: descriptionController,
      ),
    );
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter description';
    }
    return null;
  }
}
