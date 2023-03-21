// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorObject _$ActorObjectFromJson(Map<String, dynamic> json) => ActorObject(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ActorObjectToJson(ActorObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MovieObject _$MovieObjectFromJson(Map<String, dynamic> json) => MovieObject(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      title: json['title'] as String,
      summary: json['summary'] as String,
      actors: (json['actors'] as List<dynamic>)
          .map((e) => ActorObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      director: json['director'] as String,
      writers:
          (json['writers'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
      youtubeVideoId: json['youtubeVideoId'] as String,
      year: json['year'] as String,
    );

Map<String, dynamic> _$MovieObjectToJson(MovieObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'summary': instance.summary,
      'actors': instance.actors,
      'director': instance.director,
      'writers': instance.writers,
      'rating': instance.rating,
      'youtubeVideoId': instance.youtubeVideoId,
      'year': instance.year,
    };
