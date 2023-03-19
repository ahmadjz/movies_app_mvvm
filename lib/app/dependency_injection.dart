import 'package:get_it/get_it.dart';
import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance<SharedPreferences>()));
}
