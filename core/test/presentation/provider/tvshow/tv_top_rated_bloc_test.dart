import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late TvTopRatedCubit bloc;
  late MockGetTvTopRated topRated;

  setUp(() {
    topRated = MockGetTvTopRated();
    bloc = TvTopRatedCubit(topRated);
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

  blocTest<TvTopRatedCubit, TvTopRatedState>(
    'should get data from the usecases',
    build: () {
      when(topRated.execute()).thenAnswer((_) async => Right(tTvs));
      return bloc;
    },
    act: (cubit) => cubit.fetchTopRated(),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedHasData(tTvs),
    ],
  );

  blocTest<TvTopRatedCubit, TvTopRatedState>(
    'should return error when data is unsuccessful',
    build: () {
      when(topRated.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (cubit) => cubit.fetchTopRated(),
    expect: () => [
      TvTopRatedLoading(),
      const TvTopRatedError('Server Failure'),
    ],
  );
}
