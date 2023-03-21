import 'dart:convert';

import 'package:movies_app_mvvm/data/network/error_handler.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String allCategoriesKey = "ALL_CATEGORIES_KEY";
const String allMoviesKey = "ALL_MOVIES_KEY";
const String watchListKey = 'WATCH_LIST';

class AppPreferences {
  final SharedPreferences sharedPreferences;

  AppPreferences({
    required this.sharedPreferences,
  });

  Future<void> setUserLoggedIn() async {
    sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }

  Future<void> saveAllCategoriesToCache(
      AllCategoriesResponse allCategoriesResponse) async {
    final String allCategoriesJson = jsonEncode(
      allCategoriesResponse.toJson(),
    );
    await sharedPreferences.setString(
      allCategoriesKey,
      allCategoriesJson,
    );
  }

  Future<AllCategoriesResponse> getAllCategoriesFromCache() async {
    final jsonString = sharedPreferences.getString(allCategoriesKey);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);

      return AllCategoriesResponse.fromJson(jsonMap);
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  Future<void> saveAllMoviesToCache(AllMoviesResponse allMoviesResponse) async {
    final String allMoviesJson = jsonEncode(
      allMoviesResponse.toJson(),
    );
    await sharedPreferences.setString(
      allMoviesKey,
      allMoviesJson,
    );
  }

  Future<AllMoviesResponse> getAllMoviesFromCache() async {
    final jsonString = sharedPreferences.getString(allMoviesKey);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);

      return AllMoviesResponse.fromJson(jsonMap);
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  Future<List<MovieObject>> getWatchList() async {
    final watchListJson = sharedPreferences.getString(watchListKey) ?? '[]';
    final watchList = (jsonDecode(watchListJson) as List)
        .map((e) => MovieObject.fromJson(e))
        .toList();
    return watchList;
  }

  Future<void> addToWatchList(MovieObject movie) async {
    final watchList = await getWatchList();
    watchList.add(movie);
    sharedPreferences.setString(watchListKey, jsonEncode(watchList));
  }

  Future<void> removeFromWatchList(int movieId) async {
    final watchList = await getWatchList();
    watchList.removeWhere((m) => m.id == movieId);
    sharedPreferences.setString(watchListKey, jsonEncode(watchList));
  }

  Future<void> removeWatchListData() async {
    sharedPreferences.remove(watchListKey);
  }
}
