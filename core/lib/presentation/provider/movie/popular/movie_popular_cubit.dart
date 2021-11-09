import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_state.dart';

class MoviePopularCubit extends Cubit<MoviePopularState> {
  final GetPopularMovies _popular;

  MoviePopularCubit(this._popular) : super(MoviePopularEmpty());

  Future<void> fetchPopular() async {
    emit(MoviePopularLoading());
    final result = await _popular.execute();

    result.fold(
      (failure) => emit(MoviePopularError(failure.message)),
      (hasData) => emit(MoviePopularHasData(hasData)),
    );
  }
}
