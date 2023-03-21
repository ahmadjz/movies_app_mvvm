import 'package:dartz/dartz.dart';
import 'package:movies_app_mvvm/data/network/failure.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/domain/repository/repository.dart';
import 'package:movies_app_mvvm/domain/use_cases/base_use_case.dart';

class MoviesWatchListUseCase
    implements BaseUseCase<Function?, AllMoviesObject> {
  final Repository _repository;

  MoviesWatchListUseCase(this._repository);

  @override
  Future<Either<Failure, AllMoviesObject>> execute(
    Function? input,
  ) async {
    return await _repository.getWatchList();
  }

  Future<Either<Failure, void>> removeFromWatchList(
    int movieId,
  ) async {
    return await _repository.removeFromWatchList(
      movieId,
    );
  }

  Future<Either<Failure, void>> addToWatchList(
    MovieObject movie,
  ) async {
    return await _repository.addToWatchList(
      movie,
    );
  }
}
