import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_watchlist.dart';
import '../../utils/state_enum.dart';

class TvWatchlistNotifier extends ChangeNotifier {
  final GetTvWatchlist getTvWatchlist;

  TvWatchlistNotifier({required this.getTvWatchlist});

  RequestState _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  List<Tv> _watchlistTvs = [];

  List<Tv> get watchlistTvs => _watchlistTvs;

  Future<void> fetchWatchlistTvs() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getTvWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
