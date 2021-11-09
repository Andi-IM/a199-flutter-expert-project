part of 'movie_top_rated_cubit.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedEmpty extends MovieTopRatedState {}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> movies;

  const MovieTopRatedHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
