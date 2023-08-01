import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HrefTag extends StatelessWidget {
  final String href;
  final String placeholder;
  const HrefTag({
    super.key,
    required this.href,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(href);
      },
      child: Text(
        placeholder,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
        ),
      ),
    );
  }
}
