import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/app/resources/constants_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";
const String defaultLanguageValue = "en";

class DioFactory {
  final AppPreferences appPreferences;

  DioFactory({required this.appPreferences});

  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      defaultLanguage: defaultLanguageValue
    };

    dio.options = BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: headers,
        receiveTimeout: AppConstants.apiTimeOut,
        sendTimeout: AppConstants.apiTimeOut);

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
