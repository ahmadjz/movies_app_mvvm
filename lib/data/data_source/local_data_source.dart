import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';

abstract class LocalDataSource {
  Future<AllCategoriesResponse> getAllCategoriesFromCache();
  Future<AllMoviesResponse> getAllMoviesFromCache();
  Future<void> saveAllCategoriesToCache(
    AllCategoriesResponse allCategoriesResponse,
  );
  Future<void> saveAllMoviesToCache(
    AllMoviesResponse allMoviesResponse,
  );
  Future<List<MovieObject>> getWatchList();
  Future<void> addToWatchList(MovieObject movie);
  Future<void> removeFromWatchList(int movieId);
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

  @override
  Future<void> addToWatchList(MovieObject movie) async {
    return await appPreferences.addToWatchList(movie);
  }

  @override
  Future<List<MovieObject>> getWatchList() async {
    return await appPreferences.getWatchList();
  }

  @override
  Future<void> removeFromWatchList(int movieId) async {
    return await appPreferences.removeFromWatchList(movieId);
  }
}
