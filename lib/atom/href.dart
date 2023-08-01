import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_route.dart';
import '../routes/route_helper.dart';

class HrefTag extends StatelessWidget {
  final String href;
  const HrefTag({
    super.key,
    required this.href,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(
          RouteHelper.toPath(AppRoute.register),
        );
      },
      child: Text(
        href,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
        ),
      ),
    );
  }
}
