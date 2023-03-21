import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/data/data_source/local_data_source.dart';
import 'package:movies_app_mvvm/data/data_source/remote_data_source.dart';
import 'package:movies_app_mvvm/data/network/app_api.dart';
import 'package:movies_app_mvvm/data/network/dio_factory.dart';
import 'package:movies_app_mvvm/data/network/network_info.dart';
import 'package:movies_app_mvvm/data/repository/repository_implementer.dart';
import 'package:movies_app_mvvm/domain/repository/repository.dart';
import 'package:movies_app_mvvm/domain/use_cases/home_categories_use_case.dart';
import 'package:movies_app_mvvm/domain/use_cases/home_movies_use_case.dart';
import 'package:movies_app_mvvm/domain/use_cases/movies_watch_list_use_case.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view_model/movie_details_page_view_model.dart';
import 'package:movies_app_mvvm/presentation/login/view_model/login_view_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/categories/view_model/home_page_categories_view_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/movies/view_model/home_page_movies_view_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/watch_list/view_model/home_page_movies_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance<SharedPreferences>()));

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementer(
      internetConnectionChecker: InternetConnectionChecker(),
    ),
  );

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(
      appPreferences: instance<AppPreferences>(),
    ),
  );

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(
      dio,
    ),
  );

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(
      appServiceClient: instance<AppServiceClient>(),
    ),
  );

  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementer(
      appPreferences: instance<AppPreferences>(),
    ),
  );

  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementer(
      networkInfo: instance<NetworkInfo>(),
      remoteDataSource: instance<RemoteDataSource>(),
      localDataSource: instance<LocalDataSource>(),
    ),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginViewModel>()) {
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(),
    );
  }
}

initHomeCategoriesModule() {
  if (!GetIt.I.isRegistered<HomeCategoriesUseCase>()) {
    instance.registerFactory<HomeCategoriesUseCase>(
      () => HomeCategoriesUseCase(
        instance<Repository>(),
      ),
    );
    instance.registerFactory<HomePageCategoriesViewModel>(
      () => HomePageCategoriesViewModel(
        instance<HomeCategoriesUseCase>(),
      ),
    );
  }
}

initHomeMoviesModule() {
  if (!GetIt.I.isRegistered<HomeMoviesUseCase>()) {
    instance.registerFactory<HomeMoviesUseCase>(
      () => HomeMoviesUseCase(
        instance<Repository>(),
      ),
    );
    instance.registerFactory<HomePageMoviesViewModel>(
      () => HomePageMoviesViewModel(
        instance<HomeMoviesUseCase>(),
      ),
    );
  }
}

initWatchLaterMovieDetailsModule() {
  if (!GetIt.I.isRegistered<MoviesWatchListUseCase>()) {
    instance.registerFactory<MoviesWatchListUseCase>(
      () => MoviesWatchListUseCase(
        instance<Repository>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<MovieDetailsPageViewModel>()) {
    instance.registerFactory<MovieDetailsPageViewModel>(
      () => MovieDetailsPageViewModel(
        instance<MoviesWatchListUseCase>(),
      ),
    );
  }
}

initWatchLaterMoviesModule() {
  if (!GetIt.I.isRegistered<MoviesWatchListUseCase>()) {
    instance.registerFactory<MoviesWatchListUseCase>(
      () => MoviesWatchListUseCase(
        instance<Repository>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<WatchListPageViewModel>()) {
    instance.registerFactory<WatchListPageViewModel>(
      () => WatchListPageViewModel(
        instance<MoviesWatchListUseCase>(),
      ),
    );
  }
}
