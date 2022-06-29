import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_popular.dart';
import '../../utils/state_enum.dart';

class TvPopularNotifier extends ChangeNotifier {
  final GetTvPopular getTvPopular;

  TvPopularNotifier({required this.getTvPopular});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  var _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();
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
