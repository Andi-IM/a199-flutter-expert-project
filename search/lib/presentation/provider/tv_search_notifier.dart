import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/search_tvs.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvs searchTvs;

  TvSearchNotifier({required this.searchTvs});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  String _message = '';

  String get message => _message;

  List<Tv> _searchResult = [];

  List<Tv> get searchResult => _searchResult;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvs.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty){
          _message = "Yah Judul yang Kamu cari tidak ditemukan.";
          _state = RequestState.Error;
          notifyListeners();
        } else {
          _searchResult = data;
          _state = RequestState.Loaded;
          notifyListeners();
        }
      },
    );
  }
}
