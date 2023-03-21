import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/presentation/animations/loading_animation_view.dart';
import 'package:movies_app_mvvm/presentation/animations/no_data_animation_view.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/categories/view/widgets/categories_grid_builder.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/categories/view_model/home_page_categories_view_model.dart';

class HomePageCategoriesView extends StatefulWidget {
  const HomePageCategoriesView({super.key});

  @override
  State<HomePageCategoriesView> createState() => _HomePageCategoriesViewState();
}

class _HomePageCategoriesViewState extends State<HomePageCategoriesView> {
  final HomePageCategoriesViewModel _homePageCategoriesViewModel =
      instance<HomePageCategoriesViewModel>();

  @override
  void initState() {
    _homePageCategoriesViewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _homePageCategoriesViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _homePageCategoriesViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContentWidget(),
                retryActionFunction: () {
                  _homePageCategoriesViewModel.start();
                },
              ) ??
              const LoadingAnimationView();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewCategoriesObject>(
      stream: _homePageCategoriesViewModel.outputHomeData,
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
                    AppStrings.trendingCategories,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSize.s30),
                  snapshot.data!.categories.isEmpty
                      ? const NoDataAnimationView()
                      : CategoriesGridBuilder(
                          categories: snapshot.data!.categories,
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
        _homePageCategoriesViewModel.search(value);
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
