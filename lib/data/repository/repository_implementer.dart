import 'package:dartz/dartz.dart';
import 'package:movies_app_mvvm/data/data_source/remote_data_source.dart';
import 'package:movies_app_mvvm/data/mapper/categories_mapper.dart';
import 'package:movies_app_mvvm/data/network/error_handler.dart';
import 'package:movies_app_mvvm/data/network/failure.dart';
import 'package:movies_app_mvvm/data/network/network_info.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';
import 'package:movies_app_mvvm/domain/repository/repository.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  RepositoryImplementer({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AllCategoriesObject>> getAllCategoriesData() async {
    try {
      //TODO: implement getting data from cache here
      throw Failure(code: 0, message: "Caching failed");
    } catch (cacheError) {
      if (await networkInfo.isConnected) {
        try {
          final response = await remoteDataSource.getAllCategories();
          //TODO: implement save data to cache here
          return Right(response.toDomain());
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
