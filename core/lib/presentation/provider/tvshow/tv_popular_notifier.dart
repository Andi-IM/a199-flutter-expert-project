import 'package:flutter/material.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_tv_popular.dart';
import '../../../utils/state_enum.dart';

class TvPopularNotifier extends ChangeNotifier {
  final GetTvPopular getTvPopular;

  TvPopularNotifier({required this.getTvPopular});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  var _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
        (failure){
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (tvsData){
          _tvs = tvsData;
          _state = RequestState.Loaded;
          notifyListeners();
        },
    );
  }
}