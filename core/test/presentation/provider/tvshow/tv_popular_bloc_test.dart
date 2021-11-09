import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvPopular
])
void main() {
  late TvPopularCubit bloc;
  late MockGetTvPopular popular;
  
  setUp((){
    popular = MockGetTvPopular();
    bloc = TvPopularCubit(popular);
  });

  final tTv = Tv(
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
  final tTvs = [tTv];

  blocTest<TvPopularCubit, TvPopularState>(
    'should get data from the usecases',
    build: () {
      when(popular.execute())
          .thenAnswer((_) async => Right(tTvs));
      return bloc;
    },
    act: (cubit) => cubit.fetchPopular(),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(tTvs),
    ],
  );

  blocTest<TvPopularCubit, TvPopularState>(
    'should return error when data is unsuccessful',
    build: () {
      when(popular.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (cubit) => cubit.fetchPopular(),
    expect: () => [
      TvPopularLoading(),
      const TvPopularError('Server Failure'),
    ],
  );
}