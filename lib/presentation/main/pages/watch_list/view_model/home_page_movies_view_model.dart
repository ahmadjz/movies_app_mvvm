import 'dart:async';

import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/domain/use_cases/movies_watch_list_use_case.dart';
import 'package:movies_app_mvvm/presentation/base/base_view_model.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';

class WatchListPageViewModel extends BaseViewModel
    with WatchListPageViewModelInput, WatchListPageViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewMoviesObject>();
  final _filteredMoviesStreamController =
      BehaviorSubject<HomeViewMoviesObject>();

  final MoviesWatchListUseCase _moviesWatchListUseCase;
  WatchListPageViewModel(this._moviesWatchListUseCase);

  List<MovieObject> _allMovies = [];

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
    (await _moviesWatchListUseCase.execute(null)).fold(
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

abstract class WatchListPageViewModelInput {
  Sink get inputHomeData;
}

abstract class WatchListPageViewModelOutput {
  Stream<HomeViewMoviesObject> get outputHomeData;
}

class HomeViewMoviesObject {
  List<MovieObject> movies;

  HomeViewMoviesObject({required this.movies});
}
