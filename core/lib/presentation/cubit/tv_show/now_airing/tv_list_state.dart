part of 'tv_list_cubit.dart';

abstract class TvNowAiringState extends Equatable {
  const TvNowAiringState();

  @override
  List<Object> get props => [];
}

class TvNowAiringInitial extends TvNowAiringState {}

class TvNowAiringLoading extends TvNowAiringState {}

class TvNowAiringError extends TvNowAiringState {
  final String message;

  const TvNowAiringError(this.message);

  @override
  List<Object> get props => [message];
}

class TvNowAiringHasData extends TvNowAiringState {
  final List<Tv> tvs;

  const TvNowAiringHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
