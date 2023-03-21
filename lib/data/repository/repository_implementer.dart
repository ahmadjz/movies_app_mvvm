import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:movies_app_mvvm/data/data_source/local_data_source.dart';
import 'package:movies_app_mvvm/data/data_source/remote_data_source.dart';
import 'package:movies_app_mvvm/data/mapper/categories_mapper.dart';
import 'package:movies_app_mvvm/data/mapper/movies_mapper.dart';
import 'package:movies_app_mvvm/data/network/error_handler.dart';
import 'package:movies_app_mvvm/data/network/failure.dart';
import 'package:movies_app_mvvm/data/network/network_info.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/domain/repository/repository.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  RepositoryImplementer({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AllCategoriesObject>> getAllCategoriesData() async {
    try {
      final response = await localDataSource.getAllCategoriesFromCache();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await networkInfo.isConnected) {
        try {
          final response = await remoteDataSource.getAllCategories();
          localDataSource.saveAllCategoriesToCache(response);
          return Right(response.toDomain());
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AllMoviesObject>> getMoviesByCategoryId(
      int categoryId) async {
    try {
      final response = await localDataSource.getAllMoviesFromCache();
      return Right(
        _filterMoviesByCategory(
          allMoviesObject: response.toDomain(),
          categoryId: categoryId,
        ),
      );
    } catch (cacheError) {
      if (await networkInfo.isConnected) {
        try {
          final response = await remoteDataSource.getAllMovies();
          localDataSource.saveAllMoviesToCache(response);
          return Right(
            _filterMoviesByCategory(
              allMoviesObject: response.toDomain(),
              categoryId: categoryId,
            ),
          );
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  AllMoviesObject _filterMoviesByCategory({
    required AllMoviesObject allMoviesObject,
    required int categoryId,
  }) {
    return AllMoviesObject(
      movies: allMoviesObject.movies
          .where((movie) => movie.categoryId == categoryId)
          .toList(),
    );
  }

  @override
  Future<Either<Failure, AllMoviesObject>> getWatchList() async {
    try {
      final response = await localDataSource.getWatchList();
      return Right(
        AllMoviesObject(movies: response),
      );
    } catch (error) {
      return Left(
        ErrorHandler.handle(error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, void>> addToWatchList(MovieObject movie) async {
    try {
      await localDataSource.addToWatchList(movie);
      return const Right(Void);
    } catch (error) {
      return Left(
        ErrorHandler.handle(error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWatchList(int movieId) async {
    try {
      await localDataSource.removeFromWatchList(movieId);
      return const Right(Void);
    } catch (error) {
      return Left(
        ErrorHandler.handle(error).failure,
      );
    }
  }
}
