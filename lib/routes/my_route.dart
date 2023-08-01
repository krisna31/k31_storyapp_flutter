import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k31_storyapp_flutter/provider/auth_provider.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:k31_storyapp_flutter/view/error/error_screen.dart';
import 'package:k31_storyapp_flutter/view/splash/splash_screen.dart';
import 'package:k31_storyapp_flutter/view/story/stories_screen.dart';
import 'package:k31_storyapp_flutter/view/story/story_detail_screen.dart';

import '../view/authentication/login_screen.dart';
import '../view/authentication/register_screen.dart';

class MyRoute {
  late final AuthProvider authProvider;

  MyRoute({required this.authProvider});

  late final GoRouter router = GoRouter(
    refreshListenable: authProvider,
    routes: [
      GoRoute(
        path: RouteHelper.toPath(AppRoute.splash),
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.login),
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.register),
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.home),
        builder: (BuildContext context, GoRouterState state) {
          return const StoriesScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.error),
        builder: (BuildContext context, GoRouterState state) {
          return ErrorScreen(
            error: state.extra.toString(),
          );
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.detailStory),
        builder: (BuildContext context, GoRouterState state) {
          return StoryDetailScreen(
            storyId: state.pathParameters['storyId'],
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        ErrorScreen(error: state.error.toString()),
    initialLocation: RouteHelper.toPath(AppRoute.splash),
    redirect: (context, state) async {
      final isLogin = authProvider.isLogin;
      final isSplash = authProvider.isSplash;

      final isGoingToLogin =
          state.matchedLocation == RouteHelper.toPath(AppRoute.login);

      log(isSplash.toString());

      if (isSplash) {
        return RouteHelper.toPath(AppRoute.splash);
      } else if (isLogin && isGoingToLogin) {
        return RouteHelper.toPath(AppRoute.home);
      } else if (!isLogin && !isGoingToLogin) {
        return RouteHelper.toPath(AppRoute.login);
      } else {
        return null;
      }
    },
  );
}
