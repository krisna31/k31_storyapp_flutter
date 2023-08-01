import 'package:k31_storyapp_flutter/routes/app_route.dart';

class RouteHelper {
  static String toPath(AppRoute route) {
    switch (route) {
      case AppRoute.home:
        return "/";
      case AppRoute.login:
        return "/login";
      case AppRoute.register:
        return "/register";
      case AppRoute.splash:
        return "/splash";
      case AppRoute.error:
        return "/error";
      case AppRoute.detailStory:
        return "/:storyId";
      default:
        return "/";
    }
  }

  static String toTitle(AppRoute route) {
    switch (route) {
      case AppRoute.home:
        return "My App";
      case AppRoute.login:
        return "Log In";
      case AppRoute.register:
        return "Register";
      case AppRoute.splash:
        return "Splash";
      case AppRoute.error:
        return "Error";
      case AppRoute.detailStory:
        return "Welcome to My App";
      default:
        return "My App";
    }
  }
}
