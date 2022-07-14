part of 'movie_popular_cubit.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularEmpty extends MoviePopularState {}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularError extends MoviePopularState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> movies;

  const MoviePopularHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
