import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_top_rated.dart';
import '../../utils/state_enum.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  final GetTvTopRated getTvTopRated;

  TvTopRatedNotifier({required this.getTvTopRated});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  String _message = '';

  String get message => _message;

  List<Tv> _tvs = [];

  List<Tv> get tvs => _tvs;

  Future<void> fetchTopRatedTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
