// Mocks generated by Mockito 5.2.0 from annotations
// in ditonton/test/presentation/pages/tvshow/tv_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv.dart' as _i10;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart' as _i3;
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart' as _i4;
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart' as _i6;
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart' as _i5;
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetTvDetail_0 extends _i1.Fake implements _i2.GetTvDetail {}

class _FakeGetTvRecommendations_1 extends _i1.Fake
    implements _i3.GetTvRecommendations {}

class _FakeGetTvWatchlistStatus_2 extends _i1.Fake
    implements _i4.GetTvWatchlistStatus {}

class _FakeSaveTvWatchlist_3 extends _i1.Fake implements _i5.SaveTvWatchlist {}

class _FakeRemoveTvWatchlist_4 extends _i1.Fake
    implements _i6.RemoveTvWatchlist {}

class _FakeTvDetail_5 extends _i1.Fake implements _i7.TvDetail {}

/// A class which mocks [TvDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailNotifier extends _i1.Mock implements _i8.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvDetail),
          returnValue: _FakeGetTvDetail_0()) as _i2.GetTvDetail);
  @override
  _i3.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
      Invocation.getter(#getTvRecommendations),
      returnValue: _FakeGetTvRecommendations_1()) as _i3.GetTvRecommendations);
  @override
  _i4.GetTvWatchlistStatus get getTvWatchlistStatus => (super.noSuchMethod(
      Invocation.getter(#getTvWatchlistStatus),
      returnValue: _FakeGetTvWatchlistStatus_2()) as _i4.GetTvWatchlistStatus);
  @override
  _i5.SaveTvWatchlist get saveTvWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveTvWatchlist),
          returnValue: _FakeSaveTvWatchlist_3()) as _i5.SaveTvWatchlist);
  @override
  _i6.RemoveTvWatchlist get removeTvWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeTvWatchlist),
          returnValue: _FakeRemoveTvWatchlist_4()) as _i6.RemoveTvWatchlist);
  @override
  _i9.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#tvState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  _i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  _i7.TvDetail get tv => (super.noSuchMethod(Invocation.getter(#tv),
      returnValue: _FakeTvDetail_5()) as _i7.TvDetail);
  @override
  List<_i10.Tv> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendations),
          returnValue: <_i10.Tv>[]) as List<_i10.Tv>);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get isAddedtoWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedtoWatchlist),
          returnValue: false) as bool);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchTvDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchList(_i7.TvDetail? tv) => (super.noSuchMethod(
      Invocation.method(#addWatchList, [tv]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [tv]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatus, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
