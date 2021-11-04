import 'package:flutter/material.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';
import '../../../domain/usecases/get_tv_watchlist_status.dart';
import '../../../domain/usecases/remove_tv_watchlist.dart';
import '../../../domain/usecases/save_tv_watchlist.dart';
import '../../../utils/state_enum.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getTvWatchlistStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  });

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  String _message = '';
  String get message => _message;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  late TvDetail _tv;
  TvDetail get tv => _tv;

  late List<Tv> _tvRecommendations;
  List<Tv> get tvRecommendations => _tvRecommendations;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
        (failure){
          _tvState = RequestState.Error;
          _message = failure.message;
          notifyListeners();
        },
        (tv){
          _recommendationState = RequestState.Loading;
          _tv = tv;
          notifyListeners();
          recommendationResult.fold(
              (failure){
                _recommendationState = RequestState.Error;
                _message = failure.message;
              },
              (tvs){
                _recommendationState = RequestState.Loaded;
                _tvRecommendations = tvs;
              },
          );
          _tvState = RequestState.Loaded;
          notifyListeners();
        }
    );
  }

  static const tvWatchlistAddSuccessMessage = 'Added to Watchlist';
  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchList(TvDetail tv) async {
    final result = await saveTvWatchlist.execute(tv);

    await result.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
        }
    );

    await loadWatchlistStatus(tv.id);
  }

  static const tvWatchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeTvWatchlist.execute(tv);

    await result.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
        },
    );

    await loadWatchlistStatus(tv.id);
  }

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchlist => _isAddedtoWatchlist;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchlistStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
