import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/usecases/get_tv_watchlist.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetTvWatchlist _getList;
  
  TvWatchlistBloc(this._getList) : super(TvWatchlistEmpty());
  
  @override
  Stream<TvWatchlistState> mapEventToState(TvWatchlistEvent event) async* {
    if (event is GetWatchlist) {
      yield TvWatchlistLoading();
      final result = await _getList.execute();

      yield* result.fold(
            (failure) async* {
          yield TvWatchlistError(failure.message);
        },
            (data) async* {
              if (data.isEmpty){
                yield TvWatchlistEmpty();
              } else {
                yield TvWatchlistHasData(data);
              }
        },
      );
    }
  }
}
