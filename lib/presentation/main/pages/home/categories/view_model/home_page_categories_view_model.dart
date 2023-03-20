import 'dart:async';

import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';
import 'package:movies_app_mvvm/domain/use_cases/home_categories_use_case.dart';
import 'package:movies_app_mvvm/presentation/base/base_view_model.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';

class HomePageCategoriesViewModel extends BaseViewModel
    with HomePageCategoriesViewModelInput, HomePageCategoriesViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewCategoriesObject>();
  final _filteredCategoriesStreamController =
      BehaviorSubject<HomeViewCategoriesObject>();

  final HomeCategoriesUseCase _homeCategoriesUseCase;

  HomePageCategoriesViewModel(this._homeCategoriesUseCase);

  List<CategoryObject> _allCategories = [];

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _dataStreamController.close();
    _filteredCategoriesStreamController.close();
    super.dispose();
  }

  void search(String query) {
    _filteredCategoriesStreamController.add(
      HomeViewCategoriesObject(
        categories: _filterCategories(query),
      ),
    );
  }

  List<CategoryObject> _filterCategories(String query) {
    if (query.isEmpty) {
      return _allCategories;
    }
    return _allCategories
        .where(
          (category) => category.title.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  _getHomeData() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    (await _homeCategoriesUseCase.execute(null)).fold(
      (failure) => {
        inputState.add(
          ErrorState(
            StateRendererType.fullScreenErrorState,
            failure.message,
          ),
        )
      },
      (homeObject) {
        _allCategories = homeObject.categories;
        inputState.add(ContentState());
        inputHomeData.add(
          HomeViewCategoriesObject(
            categories: homeObject.categories,
          ),
        );
        _filteredCategoriesStreamController.add(
          HomeViewCategoriesObject(
            categories: homeObject.categories,
          ),
        );
      },
    );
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewCategoriesObject> get outputHomeData => Rx.merge(
        [
          _dataStreamController.stream,
          _filteredCategoriesStreamController.stream,
        ],
      );
}

abstract class HomePageCategoriesViewModelInput {
  Sink get inputHomeData;
}

abstract class HomePageCategoriesViewModelOutput {
  Stream<HomeViewCategoriesObject> get outputHomeData;
}

class HomeViewCategoriesObject {
  List<CategoryObject> categories;

  HomeViewCategoriesObject({required this.categories});
}
