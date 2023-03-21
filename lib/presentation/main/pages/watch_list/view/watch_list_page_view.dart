import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/presentation/animations/loading_animation_view.dart';
import 'package:movies_app_mvvm/presentation/animations/no_data_animation_view.dart';
import 'package:movies_app_mvvm/presentation/common/movies_list_builder.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:movies_app_mvvm/presentation/main/pages/watch_list/view_model/home_page_movies_view_model.dart';

class WatchListPageView extends StatefulWidget {
  const WatchListPageView({Key? key}) : super(key: key);

  @override
  State<WatchListPageView> createState() => _WatchListPageViewState();
}

class _WatchListPageViewState extends State<WatchListPageView> {
  final WatchListPageViewModel _watchListPageViewModel =
      instance<WatchListPageViewModel>();

  @override
  void initState() {
    _watchListPageViewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _watchListPageViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _watchListPageViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContentWidget(),
                retryActionFunction: () {
                  _watchListPageViewModel.start();
                },
              ) ??
              const LoadingAnimationView();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewMoviesObject>(
      stream: _watchListPageViewModel.outputHomeData,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _searchTextField(),
                  const SizedBox(height: AppSize.s40),
                  Text(
                    AppStrings.watchList,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorManager.lightPrimaryColor,
                        ),
                  ),
                  const SizedBox(height: AppSize.s30),
                  snapshot.data!.movies.isEmpty
                      ? const NoDataAnimationView()
                      : MoviesListBuilder(
                          movies: snapshot.data!.movies,
                          function: () => _watchListPageViewModel.start(),
                        )
                ],
              ),
            ),
          );
        }
        return const LoadingAnimationView();
      },
    );
  }

  Widget _searchTextField() {
    return TextField(
      onChanged: (value) {
        _watchListPageViewModel.search(value);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.white,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.s60),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.whiteBorder,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.s60),
          ),
        ),
        hintText: AppStrings.search,
        prefixIcon: Icon(
          Icons.search,
          color: ColorManager.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s60),
        ),
      ),
    );
  }
}
