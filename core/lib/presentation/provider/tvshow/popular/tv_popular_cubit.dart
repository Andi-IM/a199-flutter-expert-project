import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_state.dart';

class TvPopularCubit extends Cubit<TvPopularState> {
  final GetTvPopular _popular;

  TvPopularCubit(this._popular) : super(TvPopularEmpty());

  Future<void> getPopular() async {
    emit(TvPopularLoading());
    final result = await _popular.execute();

    result.fold(
      (failure) => TvPopularError(failure.message),
      (data) => TvPopularHasData(data),
    );
  }
}
