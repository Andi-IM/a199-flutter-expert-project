import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/provider/tvshow/tv_search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchBloc searchBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchBloc = TvSearchBloc(mockSearchTvs);
  });

  test('initialState of tvSearch should be empty', () {
    expect(searchBloc.state, TvSearchInitial());
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
  const tQuery = 'originalName';

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Empty] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      const TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}
