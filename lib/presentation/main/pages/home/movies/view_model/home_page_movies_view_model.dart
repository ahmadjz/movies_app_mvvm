import 'dart:async';

import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/domain/use_cases/home_movies_use_case.dart';
import 'package:movies_app_mvvm/presentation/base/base_view_model.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';

class HomePageMoviesViewModel extends BaseViewModel
    with HomePageMoviesViewModelInput, HomePageMoviesViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewMoviesObject>();
  final _filteredMoviesStreamController =
      BehaviorSubject<HomeViewMoviesObject>();

  final HomeMoviesUseCase _homeMoviesUseCase;

  HomePageMoviesViewModel(this._homeMoviesUseCase);

  List<MovieObject> _allMovies = [];

  int _categoryId = -1;

  void setCategoryId(int categoryId) {
    _categoryId = categoryId;
  }

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _dataStreamController.close();
    _filteredMoviesStreamController.close();
    super.dispose();
  }

  void search(String query) {
    _filteredMoviesStreamController.add(
      HomeViewMoviesObject(
        movies: _filterMovies(query),
      ),
    );
  }

  List<MovieObject> _filterMovies(String query) {
    if (query.isEmpty) {
      return _allMovies;
    }
    return _allMovies
        .where(
          (movie) => movie.title.toLowerCase().contains(
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
    (await _homeMoviesUseCase.execute(_categoryId)).fold(
      (failure) => {
        inputState.add(
          ErrorState(
            StateRendererType.fullScreenErrorState,
            failure.message,
          ),
        )
      },
      (homeObject) {
        _allMovies = homeObject.movies;
        inputState.add(ContentState());
        inputHomeData.add(
          HomeViewMoviesObject(
            movies: homeObject.movies,
          ),
        );
        _filteredMoviesStreamController.add(
          HomeViewMoviesObject(
            movies: homeObject.movies,
          ),
        );
      },
    );
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewMoviesObject> get outputHomeData => Rx.merge(
        [
          _dataStreamController.stream,
          _filteredMoviesStreamController.stream,
        ],
      );
}

abstract class HomePageMoviesViewModelInput {
  Sink get inputHomeData;
}

abstract class HomePageMoviesViewModelOutput {
  Stream<HomeViewMoviesObject> get outputHomeData;
}

class HomeViewMoviesObject {
  List<MovieObject> movies;

  HomeViewMoviesObject({required this.movies});
}
