import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_data_object.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}
