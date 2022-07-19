import 'dart:async';

import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getList;

  MovieWatchlistBloc(this._getList) : super(MovieWatchlistEmpty());

  @override
  Stream<MovieWatchlistState> mapEventToState(
      MovieWatchlistEvent event) async* {
    if (event is GetMovieWatchlist) {
      yield MovieWatchlistLoading();
      final result = await _getList.execute();

      yield* result.fold(
        (failure) async* {
          yield MovieWatchlistError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield MovieWatchlistEmpty();
          } else {
            yield MovieWatchlistHasData(data);
          }
        },
      );
    }
  }
}
