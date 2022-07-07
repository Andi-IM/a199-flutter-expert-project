part of 'tv_search_bloc.dart';

abstract class TvSearchEvent {
  const TvSearchEvent();
}

class TvOnQueryChanged extends TvSearchEvent {
  final String query;
  const TvOnQueryChanged(this.query);
}
