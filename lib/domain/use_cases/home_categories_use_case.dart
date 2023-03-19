import 'package:dartz/dartz.dart';
import 'package:movies_app_mvvm/data/network/failure.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';
import 'package:movies_app_mvvm/domain/use_cases/base_use_case.dart';

import '../repository/repository.dart';

class HomeCategoriesUseCase
    implements BaseUseCase<Function?, AllCategoriesObject> {
  final Repository _repository;

  HomeCategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, AllCategoriesObject>> execute(Function? input) async {
    return await _repository.getAllCategoriesData();
  }
}
