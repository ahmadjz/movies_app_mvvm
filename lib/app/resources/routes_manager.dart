import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/presentation/login/view/login_view.dart';
import 'package:movies_app_mvvm/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  AppStrings.noRouteFound,
                ),
              ),
            ));
  }
}
