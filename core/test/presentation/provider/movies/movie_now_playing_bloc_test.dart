import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieNowPlayingCubit bloc;
  late MockGetNowPlayingMovies nowPlaying;

  setUp(() {
    nowPlaying = MockGetNowPlayingMovies();
    bloc = MovieNowPlayingCubit(nowPlaying);
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

  blocTest<MovieNowPlayingCubit, MovieNowPlayingState>(
    'should get data from the usecases',
    build: () {
      when(nowPlaying.execute())
          .thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    verify: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingHasData(tMovies),
    ],
  );

  blocTest<MovieNowPlayingCubit, MovieNowPlayingState>(
    'should return error when data is unsuccessful',
    build: () {
      when(nowPlaying.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    verify: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      MovieNowPlayingLoading(),
      const MovieNowPlayingError('Server Failure'),
    ],
  );
}
