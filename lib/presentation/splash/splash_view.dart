import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/resources/constants_manager.dart';
import 'package:movies_app_mvvm/app/resources/routes_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(
      const Duration(seconds: AppConstants.splashDelay),
      _goNext,
    );
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {Navigator.pushReplacementNamed(context, Routes.mainRoute)}
          else
            Navigator.pushReplacementNamed(context, Routes.loginRoute)
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.moviesStore,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
