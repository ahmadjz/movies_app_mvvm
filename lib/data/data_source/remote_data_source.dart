import 'package:movies_app_mvvm/data/network/app_api.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AllCategoriesResponse> getAllCategories();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSourceImplementer({required this.appServiceClient});

  @override
  Future<AllCategoriesResponse> getAllCategories() async {
    return await appServiceClient.getAllCategories();
  }
}
