import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddStoryLeadingIcon extends StatelessWidget {
  const AddStoryLeadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.go('/'),
      icon: const Icon(Icons.arrow_back),
    );
  }
}
