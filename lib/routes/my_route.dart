import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:k31_storyapp_flutter/view/error/error_screen.dart';
import 'package:k31_storyapp_flutter/view/splash/splash_screen.dart';
import 'package:k31_storyapp_flutter/view/story/stories_screen.dart';
import 'package:k31_storyapp_flutter/view/story/story_detail_screen.dart';

import '../view/authentication/login_screen.dart';
import '../view/authentication/register_screen.dart';

class MyRoute {
  // late final AppService appService;
  // GoRouter get router => _goRouter;

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouteHelper.toPath(AppRoute.splash),
        name: RouteHelper.toName(AppRoute.splash),
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.login),
        name: RouteHelper.toName(AppRoute.login),
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.register),
        name: RouteHelper.toName(AppRoute.register),
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.home),
        name: RouteHelper.toName(AppRoute.home),
        builder: (BuildContext context, GoRouterState state) {
          return const StoriesScreen();
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.error),
        name: RouteHelper.toName(AppRoute.error),
        builder: (BuildContext context, GoRouterState state) {
          return ErrorScreen(
            error: state.extra.toString(),
          );
        },
      ),
      GoRoute(
        path: RouteHelper.toPath(AppRoute.detailStory),
        name: RouteHelper.toName(AppRoute.detailStory),
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
    redirect: (context, state) {
      final loginLocation =
          state.namedLocation(RouteHelper.toName(AppRoute.login));
      final registerLocation =
          state.namedLocation(RouteHelper.toName(AppRoute.register));
      final homeLocation =
          state.namedLocation(RouteHelper.toName(AppRoute.home));
      final splashLocation =
          state.namedLocation(RouteHelper.toName(AppRoute.splash));
      final detailLocatoin =
          state.namedLocation(RouteHelper.toName(AppRoute.detailStory));

      final isLogedIn = appService.loginState;
      final isInitialized = appService.initialized;
      final isOnboarded = appService.onboarding;

      final isGoingToLogin = state.matchedLocation == loginLocation;
      final isGoingToInit = state.matchedLocation == splashLocation;
      final isGoingToOnboard = state.matchedLocation == onboardLocation;

      // If not Initialized and not going to Initialized redirect to Splash
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
        // If not onboard and not going to onboard redirect to OnBoarding
      } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
        // If not logedin and not going to login redirect to Login
      } else if (isInitialized &&
          isOnboarded &&
          !isLogedIn &&
          !isGoingToLogin) {
        return loginLocation;
        // If all the scenarios are cleared but still going to any of that screen redirect to Home
      } else if ((isLogedIn && isGoingToLogin) ||
          (isInitialized && isGoingToInit) ||
          (isOnboarded && isGoingToOnboard)) {
        return homeLocation;
      } else {
        // Else Don't do anything
        return null;
      }
    },
  );
}
