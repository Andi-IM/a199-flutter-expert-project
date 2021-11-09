import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_now_airing_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvOnTheAir
])
void main() {
  late TvNowAiringCubit bloc;
  late MockGetTvOnTheAir onAir;
  
  setUp((){
    onAir = MockGetTvOnTheAir();
    bloc = TvNowAiringCubit(onAir);
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

  blocTest<TvNowAiringCubit, TvNowAiringState>(
    'should get data from the usecases',
    build: () {
      when(onAir.execute())
          .thenAnswer((_) async => Right(tTvs));
      return bloc;
    },
    act: (cubit) => cubit.fetchNowAiring(),
    expect: () => [
      TvNowAiringLoading(),
      TvNowAiringHasData(tTvs),
    ],
  );

  blocTest<TvNowAiringCubit, TvNowAiringState>(
    'should return error when data is unsuccessful',
    build: () {
      when(onAir.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (cubit) => cubit.fetchNowAiring(),
    expect: () => [
      TvNowAiringLoading(),
      const TvNowAiringError('Server Failure'),
    ],
  );
}