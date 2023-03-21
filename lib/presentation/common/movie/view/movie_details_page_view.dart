import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/functions.dart';
import 'package:movies_app_mvvm/app/resources/assets_manager.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/font_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/presentation/animations/loading_animation_view.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view/widgets/actors_list_builder.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view/widgets/movie_data.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view/widgets/youtube_thumbnail_image.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view_model/movie_details_page_view_model.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieObject movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieDetailsPageViewModel _movieDetailsPageViewModel =
      instance<MovieDetailsPageViewModel>();

  @override
  void initState() {
    _movieDetailsPageViewModel.setMovie(widget.movie);
    _movieDetailsPageViewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _movieDetailsPageViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: StreamBuilder<FlowState>(
              stream: _movieDetailsPageViewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getScreenWidget(
                      context: context,
                      contentScreenWidget: _getContentWidget(),
                      retryActionFunction: () {
                        _movieDetailsPageViewModel.start();
                      },
                    ) ??
                    const LoadingAnimationView();
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _getContentWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubeThumbnailImage(youtubeVideoId: widget.movie.youtubeVideoId),
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
                  width:
                      MediaQuery.of(context).size.width * PercentageSizes.p30,
                  height:
                      MediaQuery.of(context).size.width * PercentageSizes.p40,
                  fit: BoxFit.cover,
                  image: Image.network(
                    width:
                        MediaQuery.of(context).size.width * PercentageSizes.p30,
                    height:
                        MediaQuery.of(context).size.width * PercentageSizes.p40,
                    getMovieImageUrl(widget.movie.id),
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
                  height:
                      MediaQuery.of(context).size.width * PercentageSizes.p40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p12),
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
                          widget.movie.title,
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: AppSize.s160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.movie.year,
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
                                displayMovieRating(widget.movie.rating),
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
                        StreamBuilder<bool>(
                            stream: _movieDetailsPageViewModel
                                .outIsMovieInWatchList,
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(
                                            AppSize.s160, AppSize.s40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s60),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await _movieDetailsPageViewModel
                                            .toggleMovieWatchList();
                                      },
                                      child: Text(
                                        snapshot.data!
                                            ? AppStrings.removeFromWatchList
                                            : AppStrings.addToWatchList,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                color: ColorManager.white,
                                                fontSize: FontSize.s14),
                                      ),
                                    )
                                  : const Text(
                                      AppStrings.loading,
                                    );
                            })
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
                MovieData(movie: widget.movie),
                const SizedBox(height: AppSize.s16),
                Text(
                  AppStrings.cast,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSize.s18),
                ActorsListBuilder(actors: widget.movie.actors),
              ],
            ),
          ),
        ],
      );
}
