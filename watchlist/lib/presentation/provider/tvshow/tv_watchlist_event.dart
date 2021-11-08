part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetWatchlist extends TvWatchlistEvent {}
