import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_route.dart';
import '../routes/route_helper.dart';

class AddFAB extends StatelessWidget {
  const AddFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.go(RouteHelper.toPath(AppRoute.addStory)),
      child: const Icon(Icons.add),
    );
  }
}
