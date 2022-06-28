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

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirState;

  String _message = '';
  String get message => _message;

  var _onTheAirTvs = <Tv>[];
  List<Tv> get onTheAirTvs => _onTheAirTvs;

  Future<void> fetchOnTheAirTvs() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _onTheAirState = RequestState.Loaded;
        _onTheAirTvs = tvsData;
        notifyListeners();
      },
    );
  }

  RequestState _popularTvsState = RequestState.Empty;
  RequestState get popularTvsState => _popularTvsState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.Loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }

  RequestState _topRatedTvsState = RequestState.Empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  var _topRatedTvs = <Tv>[];
  get topRatedTvs => _topRatedTvs;

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvsState = RequestState.Loaded;
        _topRatedTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
