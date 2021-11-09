part of 'movie_list_cubit.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
}

class MovieListInitial extends MovieListState {
  @override
  List<Object> get props => [];
}
