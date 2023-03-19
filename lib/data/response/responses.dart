import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  CategoryResponse({
    this.id,
    this.title,
  });

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}

@JsonSerializable()
class AllCategoriesResponse {
  @JsonKey(name: 'categories')
  List<CategoryResponse>? categories;

  AllCategoriesResponse(this.categories);

  Map<String, dynamic> toJson() => _$AllCategoriesResponseToJson(this);

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$AllCategoriesResponseFromJson(json);
}
