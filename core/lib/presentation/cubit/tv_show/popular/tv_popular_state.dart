part of 'tv_popular_cubit.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class TvPopularEmpty extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularError extends TvPopularState {
  final String message;

  const TvPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class TvPopularHasData extends TvPopularState {
  final List<Tv> tvs;

  const TvPopularHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
