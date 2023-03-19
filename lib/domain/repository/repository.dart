import 'package:dartz/dartz.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, AllCategoriesObject>> getAllCategoriesData();
}
