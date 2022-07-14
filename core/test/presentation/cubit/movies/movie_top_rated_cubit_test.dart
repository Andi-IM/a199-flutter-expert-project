import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedCubit bloc;
  late MockGetTopRatedMovies topRated;

  setUp(() {
    topRated = MockGetTopRatedMovies();
    bloc = MovieTopRatedCubit(topRated);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  blocTest<MovieTopRatedCubit, MovieTopRatedState>(
    'should get data from the usecases',
    build: () {
      when(topRated.execute()).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (cubit) => cubit.fetchTopRated(),
    verify: (cubit) => cubit.fetchTopRated(),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedHasData(tMovies),
    ],
  );

  blocTest<MovieTopRatedCubit, MovieTopRatedState>(
    'should return error when data is unsuccessful',
    build: () {
      when(topRated.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (cubit) => cubit.fetchTopRated(),
    verify: (cubit) => cubit.fetchTopRated(),
    expect: () => [
      MovieTopRatedLoading(),
      const MovieTopRatedError('Server Failure'),
    ],
  );
}
