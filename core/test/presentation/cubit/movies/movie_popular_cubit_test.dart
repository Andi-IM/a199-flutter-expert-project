import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_popular_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularCubit bloc;
  late MockGetPopularMovies popular;

  setUp(() {
    popular = MockGetPopularMovies();
    bloc = MoviePopularCubit(popular);
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

  blocTest<MoviePopularCubit, MoviePopularState>(
    'should get data from the usecases',
    build: () {
      when(popular.execute()).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (cubit) => cubit.fetchPopular(),
    verify: (cubit) => cubit.fetchPopular(),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(tMovies),
    ],
  );

  blocTest<MoviePopularCubit, MoviePopularState>(
    'should return error when data is unsuccessful',
    build: () {
      when(popular.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (cubit) => cubit.fetchPopular(),
    verify: (cubit) => cubit.fetchPopular(),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError('Server Failure'),
    ],
  );
}
