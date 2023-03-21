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

ActorResponse _$ActorsResponseFromJson(Map<String, dynamic> json) =>
    ActorResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ActorsResponseToJson(ActorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      id: json['id'] as int?,
      categoryId: json['category_id'] as int?,
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      actors: (json['actors'] as List<dynamic>?)
          ?.map((e) => ActorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      director: json['director'] as String?,
      writers:
          (json['writers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      youtubeVideoId: json['youtube_video_id'] as String?,
      year: json['year'] as String?,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'title': instance.title,
      'summary': instance.summary,
      'actors': instance.actors,
      'director': instance.director,
      'writers': instance.writers,
      'rating': instance.rating,
      'youtube_video_id': instance.youtubeVideoId,
      'year': instance.year,
    };

AllMoviesResponse _$AllMoviesResponseFromJson(Map<String, dynamic> json) =>
    AllMoviesResponse(
      (json['movies'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllMoviesResponseToJson(AllMoviesResponse instance) =>
    <String, dynamic>{
      'movies': instance.movies,
    };
