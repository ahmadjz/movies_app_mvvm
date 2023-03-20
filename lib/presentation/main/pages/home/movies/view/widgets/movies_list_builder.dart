import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/movies/view/widgets/movie_item_widget.dart';

class MoviesListBuilder extends StatelessWidget {
  const MoviesListBuilder({
    Key? key,
    required this.movies,
  }) : super(key: key);
  final List<MovieObject> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: MovieItemWidget(
            movie: movies[index],
          ),
        );
      },
    );
  }
}
