import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _nowPlayingMovies;
  final GetPopularMovies _popularMovies;
  final GetTopRatedMovies _topRatedMovies;

  MovieListBloc(
    this._popularMovies,
    this._nowPlayingMovies,
    this._topRatedMovies,
  ) : super(MovieListInitial()) {
    on<MovieListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
