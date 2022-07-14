import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_tv_watchlist.dart';
import 'package:watchlist/presentation/provider/tvshow/tv_watchlist_bloc.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvWatchlist,
])
void main() {
  late TvWatchlistBloc bloc;
  late MockGetTvWatchlist mockGetTvWatchlist;

  setUp(() {
    mockGetTvWatchlist = MockGetTvWatchlist();
    bloc = TvWatchlistBloc(mockGetTvWatchlist);
  });

  test('initialState of tvWatchlist should be empty', () {
    expect(bloc.state, TvWatchlistEmpty());
  });

  final tTvModel = Tv(
    posterPath: "posterPath",
    popularity: 1,
    id: 1,
    backdropPath: "backdropPath",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: "firstAirDate",
    originCountry: const [],
    genreIds: const [1, 2, 3],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
  );
  final tTvList = <Tv>[tTvModel];

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvWatchlist.execute())
          .thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvWatchlist.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvWatchlist.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(GetWatchlist()),
      expect: () => [
            TvWatchlistLoading(),
            const TvWatchlistError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTvWatchlist.execute());
      });
}
