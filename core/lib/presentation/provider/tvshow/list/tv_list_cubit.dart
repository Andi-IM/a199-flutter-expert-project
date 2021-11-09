import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_state.dart';

class TvNowAiringCubit extends Cubit<TvNowAiringState> {
  final GetTvOnTheAir _onAir;

  TvNowAiringCubit(this._onAir) : super(TvNowAiringInitial());

  Future<void> fetchNowAiring() async {
    emit(TvNowAiringLoading());
    final result = await _onAir.execute();

    result.fold(
      (failure) => emit(TvNowAiringError(failure.message)),
      (data) => emit(TvNowAiringHasData(data)),
    );
  }
}
