import 'package:movies_app_mvvm/app/extensions.dart';
import 'package:movies_app_mvvm/app/resources/constants_manager.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';

extension ActorsMapper on ActorsResponse? {
  ActorsObject toDomain() {
    return ActorsObject(
      id: this?.id.orZero() ?? AppConstants.zero,
      name: this?.name.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension MovieMapper on MovieResponse? {
  MovieObject toDomain() {
    List<ActorsObject> actors =
        (this?.actors?.map((actor) => actor.toDomain()) ??
                const Iterable.empty())
            .cast<ActorsObject>()
            .toList();

    return MovieObject(
      id: this?.id.orZero() ?? AppConstants.zero,
      categoryId: this?.categoryId.orZero() ?? AppConstants.zero,
      title: this?.title.orEmpty() ?? AppConstants.empty,
      summary: this?.summary.orEmpty() ?? AppConstants.empty,
      actors: actors,
      director: this?.director.orEmpty() ?? AppConstants.empty,
      writers: this?.writers ?? const [],
      rating: this?.rating.orZero() ?? AppConstants.zeroDouble,
      youtubeVideoId: this?.youtubeVideoId.orEmpty() ?? AppConstants.empty,
      year: this?.year.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension AllMoviesMapper on AllMoviesResponse? {
  AllMoviesObject toDomain() {
    List<MovieObject> movies =
        (this?.movies?.map((movie) => movie.toDomain()) ??
                const Iterable.empty())
            .cast<MovieObject>()
            .toList();

    return AllMoviesObject(movies: movies);
  }
}
