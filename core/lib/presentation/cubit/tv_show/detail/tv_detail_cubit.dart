import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetTvDetail _detail;
  final GetTvRecommendations _recommendations;
  final GetTvWatchlistStatus _status;
  final SaveTvWatchlist _save;
  final RemoveTvWatchlist _remove;

  TvDetailCubit(
    this._detail,
    this._recommendations,
    this._status,
    this._save,
    this._remove,
  ) : super(TvDetailState.initialState());

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
      (tv) async {
        emit(state.copyWith(isDetailLoading: false, tv: tv));
        final recommendation = await _recommendations.execute(id);
        recommendation.fold(
          (failure) async {
            emit(state.copyWith(
                isRecommendationLoading: false, message: failure.message));
          },
          (tvs) async {
            emit(state.copyWith(
                isRecommendationLoading: false, recommendations: tvs));
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

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await _save.execute(tv);

    result.fold(
      (failure) async {
        emit(state.copyWith(saveErrorMessage: failure.message));
      },
      (success) async {
        emit(state.copyWith(saveMessage: success));
      },
    );

    getSaveStatus(tv.id);
  }

  removeWatchlist(TvDetail tv) async {
    final result = await _remove.execute(tv);

    result.fold(
      (failure) async {
        emit(state.copyWith(saveErrorMessage: failure.message));
      },
      (success) async {
        emit(state.copyWith(saveMessage: success));
      },
    );

    getSaveStatus(tv.id);
  }
}
