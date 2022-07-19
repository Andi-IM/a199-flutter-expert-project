import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail _detail;
  final GetMovieRecommendations _recommendations;
  final GetWatchListStatus _status;
  final SaveWatchlist _save;
  final RemoveWatchlist _remove;

  MovieDetailCubit(
    this._detail,
    this._recommendations,
    this._status,
    this._save,
    this._remove,
  ) : super(MovieDetailState.initialState());

  Future<void> getDetail(int id) async {
    emit(state.copyWith(
        isDetailLoading: true,
        isRecommendationLoading: true,
        clearError: true));
    final result = await _detail.execute(id);

    result.fold(
      (failure) async {
        emit(state.copyWith(
          isDetailLoading: false,
          isRecommendationLoading: false,
          message: failure.message,
        ));
      },
      (movie) async {
        emit(state.copyWith(isDetailLoading: false, movie: movie));
        final recommendation = await _recommendations.execute(id);
        recommendation.fold(
          (failure) async {
            emit(state.copyWith(
                isRecommendationLoading: false, message: failure.message));
          },
          (movies) async {
            emit(state.copyWith(
                isRecommendationLoading: false, recommendations: movies));
          },
        );
      },
    );
  }

  Future<void> getSaveStatus(int id) async {
    final result = await _status.execute(id);
    emit(state.copyWith(
        isSaved: result, clearMessage: true, clearSaveError: true));
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await _save.execute(movie);

    result.fold(
      (failure) async {
        emit(state.copyWith(saveErrorMessage: failure.message));
      },
      (success) async {
        emit(state.copyWith(saveMessage: success));
      },
    );

    getSaveStatus(movie.id);
  }

  removeWatchlist(MovieDetail movie) async {
    final result = await _remove.execute(movie);

    result.fold(
      (failure) async {
        emit(state.copyWith(saveErrorMessage: failure.message));
      },
      (success) async {
        emit(state.copyWith(saveMessage: success));
      },
    );

    getSaveStatus(movie.id);
  }
}
