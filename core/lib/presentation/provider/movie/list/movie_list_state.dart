part of 'movie_list_cubit.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String error;

  const MovieNowPlayingError(this.error);

  @override
  List<Object> get props => [error];
}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> data;

  const MovieNowPlayingHasData(this.data);

  @override
  List<Object> get props => [data];
}
