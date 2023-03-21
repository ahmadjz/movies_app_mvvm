import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_mvvm/app/functions.dart';
import 'package:movies_app_mvvm/app/resources/assets_manager.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/font_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/movie/view/widgets/actors_list_builder.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/movie/view/widgets/movie_data.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/movie/view/widgets/youtube_thumbnail_image.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieObject movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubeThumbnailImage(youtubeVideoId: movie.youtubeVideoId),
              const SizedBox(height: AppSize.s16),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    child: FadeInImage(
                      // TODO: This code works for handling no available image
                      // but it still throws an exception in the IDE
                      // that problem is cause by Flutter team and not solved yet
                      // https://github.com/flutter/flutter/issues/69125
                      // https://github.com/flutter/flutter/issues/107416
                      width: MediaQuery.of(context).size.width *
                          PercentageSizes.p30,
                      height: MediaQuery.of(context).size.width *
                          PercentageSizes.p40,
                      fit: BoxFit.cover,
                      image: Image.network(
                        width: MediaQuery.of(context).size.width *
                            PercentageSizes.p30,
                        height: MediaQuery.of(context).size.width *
                            PercentageSizes.p40,
                        getMovieImageUrl(movie.id),
                        fit: BoxFit.cover,
                      ).image,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          width: MediaQuery.of(context).size.width *
                              PercentageSizes.p30,
                          height: MediaQuery.of(context).size.width *
                              PercentageSizes.p40,
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
                      height: MediaQuery.of(context).size.width *
                          PercentageSizes.p40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              movie.title,
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: AppSize.s160,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    movie.year,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: ColorManager.white,
                                        ),
                                  ),
                                  const SizedBox(width: AppSize.s20),
                                  SvgPicture.asset(
                                    ImageAssets.starIcon,
                                  ),
                                  Text(
                                    displayMovieRating(movie.rating),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: ColorManager.white,
                                            fontSize: FontSize.s16),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                    const Size(AppSize.s160, AppSize.s40),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s60),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                AppStrings.addToWatchList,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieData(movie: movie),
                    const SizedBox(height: AppSize.s16),
                    Text(
                      AppStrings.cast,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppSize.s18),
                    ActorsListBuilder(actors: movie.actors),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
