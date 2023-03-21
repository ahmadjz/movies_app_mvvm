import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/domain/use_cases/movies_watch_list_use_case.dart';
import 'package:movies_app_mvvm/presentation/base/base_view_model.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:movies_app_mvvm/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsPageViewModel extends BaseViewModel
    with MovieDetailsPageViewModelInputs, MovieDetailsPageViewModelOutputs {
  final BehaviorSubject<bool> _isMovieInWatchListStreamController =
      BehaviorSubject<bool>();

  final MoviesWatchListUseCase _moviesWatchListUseCase;
  MovieDetailsPageViewModel(this._moviesWatchListUseCase);

  List<MovieObject> _watchListMovies = [];

  late MovieObject movieObject;

  void setMovie(MovieObject movie) {
    movieObject = movie;
  }

  @override
  void start() {
    _getWatchListData();
  }

  @override
  void dispose() {
    super.dispose();
    _isMovieInWatchListStreamController.close();
  }

  _getWatchListData() async {
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
      (homeObject) async {
        _watchListMovies = homeObject.movies;
        _isMovieInWatchListStreamController.add(await isInWatchList());
        inputState.add(ContentState());
      },
    );
  }

  @override
  Stream<bool> get outIsMovieInWatchList =>
      _isMovieInWatchListStreamController.stream;

  @override
  Future<void> toggleMovieWatchList() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    if (_isMovieInWatchListStreamController.value) {
      (await _moviesWatchListUseCase.removeFromWatchList(movieObject.id)).fold(
        (failure) {
          inputState.add(
            ErrorState(
              StateRendererType.popupErrorState,
              failure.message,
            ),
          );
        },
        (r) {
          _removeMovieFromWatchList();
          _isMovieInWatchListStreamController.add(false);
          inputState.add(
            ContentState(),
          );
        },
      );
    } else {
      (await _moviesWatchListUseCase.addToWatchList(movieObject)).fold(
        (failure) {
          inputState.add(
            ErrorState(
              StateRendererType.popupErrorState,
              failure.message,
            ),
          );
        },
        (r) {
          _watchListMovies.add(movieObject);
          _isMovieInWatchListStreamController.add(true);
          inputState.add(
            ContentState(),
          );
        },
      );
    }
  }

  Future<bool> isInWatchList() async {
    return _watchListMovies.any((m) => m.id == movieObject.id);
  }

  void _removeMovieFromWatchList() {
    _watchListMovies.removeWhere((m) => m.id == movieObject.id);
  }
}

abstract class MovieDetailsPageViewModelInputs {
  Future<void> toggleMovieWatchList();
}

abstract class MovieDetailsPageViewModelOutputs {
  Stream<bool> get outIsMovieInWatchList;
}
