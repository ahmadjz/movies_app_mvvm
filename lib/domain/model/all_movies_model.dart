import 'package:json_annotation/json_annotation.dart';

part 'all_movies_model.g.dart';

@JsonSerializable()
class ActorObject {
  final int id;
  final String name;

  ActorObject({
    required this.id,
    required this.name,
  });

  factory ActorObject.fromJson(Map<String, dynamic> json) =>
      _$ActorObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ActorObjectToJson(this);
}

@JsonSerializable()
class MovieObject {
  final int id;
  final int categoryId;
  final String title;
  final String summary;
  final List<ActorObject> actors;
  final String director;
  final List<String> writers;
  final double rating;
  final String youtubeVideoId;
  final String year;

  MovieObject({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.summary,
    required this.actors,
    required this.director,
    required this.writers,
    required this.rating,
    required this.youtubeVideoId,
    required this.year,
  });

  factory MovieObject.fromJson(Map<String, dynamic> json) =>
      _$MovieObjectFromJson(json);
  Map<String, dynamic> toJson() => _$MovieObjectToJson(this);
}

class AllMoviesObject {
  List<MovieObject> movies;

  AllMoviesObject({required this.movies});
}
