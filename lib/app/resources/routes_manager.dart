import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/presentation/animations/error_animation_view.dart';
import 'package:movies_app_mvvm/presentation/login/view/login_view.dart';
import 'package:movies_app_mvvm/presentation/main/main_view.dart';
import 'package:movies_app_mvvm/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String mainRoute = "/main";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.mainRoute:
        initHomeCategoriesModule();
        return MaterialPageRoute(
          builder: (_) => const MainView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: ErrorAnimationView(),
      ),
    );
  }
}
