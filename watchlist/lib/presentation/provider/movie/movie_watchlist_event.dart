part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object?> get props => [];
}

class GetMovieWatchlist extends MovieWatchlistEvent {}
