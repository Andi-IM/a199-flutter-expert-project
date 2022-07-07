part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class OnQueryChanged extends SearchEvent {
  final String query;

  const OnQueryChanged(this.query);
}
