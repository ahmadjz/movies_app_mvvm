import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';

abstract class LocalDataSource {
  Future<AllCategoriesResponse> getAllCategoriesFromCache();
  Future<AllMoviesResponse> getAllMoviesFromCache();
  Future<void> saveAllCategoriesToCache(
    AllCategoriesResponse allCategoriesResponse,
  );
  Future<void> saveAllMoviesToCache(
    AllMoviesResponse allMoviesResponse,
  );
}

class LocalDataSourceImplementer implements LocalDataSource {
  final AppPreferences appPreferences;

  LocalDataSourceImplementer({required this.appPreferences});

  @override
  Future<void> saveAllCategoriesToCache(
      AllCategoriesResponse allCategoriesResponse) async {
    return await appPreferences.saveAllCategoriesToCache(allCategoriesResponse);
  }

  @override
  Future<AllCategoriesResponse> getAllCategoriesFromCache() async {
    return await appPreferences.getAllCategoriesFromCache();
  }

  @override
  Future<void> saveAllMoviesToCache(AllMoviesResponse allMoviesResponse) async {
    return await appPreferences.saveAllMoviesToCache(allMoviesResponse);
  }

  @override
  Future<AllMoviesResponse> getAllMoviesFromCache() async {
    return await appPreferences.getAllMoviesFromCache();
  }
}
