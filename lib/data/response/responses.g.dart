// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

AllCategoriesResponse _$AllCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    AllCategoriesResponse(
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCategoriesResponseToJson(
        AllCategoriesResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };
