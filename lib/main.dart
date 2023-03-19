import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/app.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}
