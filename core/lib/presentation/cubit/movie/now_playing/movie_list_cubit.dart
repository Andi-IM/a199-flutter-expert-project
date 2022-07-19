import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_state.dart';

class MovieNowPlayingCubit extends Cubit<MovieNowPlayingState> {
  final GetNowPlayingMovies _nowPlaying;

  MovieNowPlayingCubit(this._nowPlaying) : super(MovieNowPlayingInitial());

  Future<void> fetchNowPlayingMovies() async {
    emit(MovieNowPlayingLoading());
    final result = await _nowPlaying.execute();

    result.fold(
      (failure) => emit(MovieNowPlayingError(failure.message)),
      (data) => emit(MovieNowPlayingHasData(data)),
    );
  }
}
