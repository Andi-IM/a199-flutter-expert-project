import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedCubit extends Cubit<TvTopRatedState> {
  final GetTvTopRated _topRated;

  TvTopRatedCubit(this._topRated) : super(TvTopRatedEmpty());

  Future<void> fetchTopRated() async {
    emit(TvTopRatedLoading());
    final result = await _topRated.execute();

    result.fold(
      (failure) => emit(TvTopRatedError(failure.message)),
      (data) => emit(TvTopRatedHasData(data)),
    );
  }
}
