import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/functions.dart';
import 'package:movies_app_mvvm/app/resources/assets_manager.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/font_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view/movie_details_page_view.dart';

class MovieItemWidget extends StatelessWidget {
  const MovieItemWidget({
    super.key,
    required this.movie,
    this.function,
  });
  final MovieObject movie;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        initWatchLaterMovieDetailsModule();
        Navigator.of(context, rootNavigator: false)
            .push(
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        )
            .then((value) {
          if (function != null) {
            function!();
          }
        });
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s16),
            child: FadeInImage(
              // TODO: This code works for handling no available image
              // but it still throws an exception in the IDE
              // that problem is cause by Flutter team and not solved yet
              // https://github.com/flutter/flutter/issues/69125
              // https://github.com/flutter/flutter/issues/107416
              width: MediaQuery.of(context).size.width * PercentageSizes.p30,
              height: MediaQuery.of(context).size.width * PercentageSizes.p30,
              fit: BoxFit.cover,
              image: Image.network(
                width: MediaQuery.of(context).size.width * PercentageSizes.p30,
                height: MediaQuery.of(context).size.width * PercentageSizes.p30,
                getMovieImageUrl(movie.id),
                fit: BoxFit.cover,
              ).image,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  width:
                      MediaQuery.of(context).size.width * PercentageSizes.p30,
                  height:
                      MediaQuery.of(context).size.width * PercentageSizes.p30,
                  ImageAssets.movieErrorPlaceholder,
                  fit: BoxFit.cover,
                );
              },
              placeholder: const AssetImage(
                ImageAssets.moviePlaceholder,
              ),
            ),
          ),
          const SizedBox(width: AppSize.s10),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width * PercentageSizes.p30,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.greyCard,
                borderRadius: BorderRadius.circular(AppSize.s16),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      movie.year,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.starIcon,
                        ),
                        const SizedBox(width: AppSize.s4),
                        Text(
                          displayMovieRating(movie.rating),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: FontSize.s10,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
