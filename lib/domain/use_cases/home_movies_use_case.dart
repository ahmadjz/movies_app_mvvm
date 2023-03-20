import 'package:dartz/dartz.dart';
import 'package:movies_app_mvvm/data/network/failure.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/domain/repository/repository.dart';
import 'package:movies_app_mvvm/domain/use_cases/base_use_case.dart';

class HomeMoviesUseCase implements BaseUseCase<int, AllMoviesObject> {
  final Repository _repository;

  HomeMoviesUseCase(this._repository);

  @override
  Future<Either<Failure, AllMoviesObject>> execute(int categoryId) async {
    return await _repository.getMoviesByCategoryId(
      categoryId,
    );
  }
}
