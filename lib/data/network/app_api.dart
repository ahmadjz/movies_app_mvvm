import 'package:dio/dio.dart';
import 'package:movies_app_mvvm/app/resources/constants_manager.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET("movies_categories.json")
  Future<AllCategoriesResponse> getAllCategories();
}
