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

@JsonSerializable()
class ActorsResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  ActorsResponse({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() => _$ActorsResponseToJson(this);

  factory ActorsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorsResponseFromJson(json);
}

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'summary')
  String? summary;

  @JsonKey(name: 'actors')
  List<ActorsResponse>? actors;

  @JsonKey(name: 'director')
  String? director;

  @JsonKey(name: 'writers')
  List<String>? writers;

  @JsonKey(name: 'rating')
  double? rating;

  @JsonKey(name: 'youtube_video_id')
  String? youtubeVideoId;

  @JsonKey(name: 'year')
  String? year;

  MovieResponse({
    this.id,
    this.categoryId,
    this.title,
    this.summary,
    this.actors,
    this.director,
    this.writers,
    this.rating,
    this.youtubeVideoId,
    this.year,
  });

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}

@JsonSerializable()
class AllMoviesResponse {
  @JsonKey(name: 'movies')
  List<MovieResponse>? movies;

  AllMoviesResponse(this.movies);

  Map<String, dynamic> toJson() => _$AllMoviesResponseToJson(this);

  factory AllMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$AllMoviesResponseFromJson(json);
}
