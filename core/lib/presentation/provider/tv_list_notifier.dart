import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_on_the_air.dart';
import '../../domain/usecases/get_tv_popular.dart';
import '../../domain/usecases/get_tv_top_rated.dart';
import '../../utils/state_enum.dart';

class TvListProvider extends ChangeNotifier {
  final GetTvOnTheAir getTvOnTheAir;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvTopRated;

  TvListProvider({
    required this.getTvOnTheAir,
    required this.getTvPopular,
    required this.getTvTopRated,
  });

  RequestState _onTheAirState = RequestState.empty;
  RequestState get onTheAirState => _onTheAirState;

  String _message = '';
  String get message => _message;

  var _onTheAirTvs = <Tv>[];
  List<Tv> get onTheAirTvs => _onTheAirTvs;

  Future<void> fetchOnTheAirTvs() async {
    _onTheAirState = RequestState.loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _onTheAirState = RequestState.loaded;
        _onTheAirTvs = tvsData;
        notifyListeners();
      },
    );
  }

  RequestState _popularTvsState = RequestState.empty;
  RequestState get popularTvsState => _popularTvsState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }

  RequestState _topRatedTvsState = RequestState.empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  var _topRatedTvs = <Tv>[];
  get topRatedTvs => _topRatedTvs;

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvsState = RequestState.loaded;
        _topRatedTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
