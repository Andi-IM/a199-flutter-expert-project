import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tvs.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(TvSearchEmpty());

  // ignore: deprecation
  @override
  Stream<Transition<TvSearchEvent, TvSearchState>> transformEvents(
    Stream<TvSearchEvent> events,
    TransitionFunction<TvSearchEvent, TvSearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<TvSearchState> mapEventToState(TvSearchEvent event) async* {
    if (event is OnTvQueryChanged) {
      final query = event.query;

      yield TvSearchLoading();
      final result = await _searchTvs.execute(query);

      yield* result.fold(
        (failure) async* {
          yield TvSearchError(failure.message);
        },
        (data) async* {
          yield TvSearchHasData(data);
        },
      );
    }
  }
}
