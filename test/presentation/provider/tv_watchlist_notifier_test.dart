import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/presentation/provider/tv_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvWatchlist,
])
void main() {
  late TvWatchlistNotifier notifier;
  late MockGetTvWatchlist mockGetTvWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvWatchlist = MockGetTvWatchlist();
    notifier = TvWatchlistNotifier(getTvWatchlist: mockGetTvWatchlist)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('Tv Watchlist Notifier', (){
    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetTvWatchlist.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      // act
      await notifier.fetchWatchlistTvs();
      // assert
      expect(notifier.watchlistState, RequestState.Loaded);
      expect(notifier.watchlistTvs, [testWatchlistTv]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvWatchlist.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await notifier.fetchWatchlistTvs();
      // assert
      expect(notifier.watchlistState, RequestState.Error);
      expect(notifier.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}
