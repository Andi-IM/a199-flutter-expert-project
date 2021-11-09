import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailCubit bloc;
  late MockGetMovieDetail detail;
  late MockGetMovieRecommendations recommendations;
  late MockGetWatchListStatus status;
  late MockSaveWatchlist save;
  late MockRemoveWatchlist remove;

  setUp(() {
    detail = MockGetMovieDetail();
    recommendations = MockGetMovieRecommendations();
    status = MockGetWatchListStatus();
    save = MockSaveWatchlist();
    remove = MockRemoveWatchlist();
    bloc = MovieDetailCubit(
      detail,
      recommendations,
      status,
      save,
      remove,
    );
  });

  const tId = 1;
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

  test('state should be initial', () async {
    expect(bloc.state, MovieDetailState.initialState());
  });

  group('Get Movie Detail', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should get data from the usecases',
      build: () {
        when(detail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(recommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (cubit) => cubit.getDetail(tId),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: true,
          isRecommendationLoading: true,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: true,
          isSaved: false,
          movie: testMovieDetail,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
        MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: testMovieDetail,
          recommendations: tMovies,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should return error when data is unsuccessful',
      build: () {
        when(detail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        when(recommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (cubit) => cubit.getDetail(tId),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: true,
          isRecommendationLoading: true,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: "Server Failure",
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should get the watchlist status',
      build: () {
        when(status.execute(1)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.getSaveStatus(tId),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should update save watchlist status when add watchlist success',
      build: () {
        when(save.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(status.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      verify: (cubit) => cubit.addWatchlist(testMovieDetail),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: "Added to Watchlist",
          saveErrorMessage: null,
        ),
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),

      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should show error when add watchlist failed',
      build: () {
        when(save.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(status.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      verify: (cubit) => cubit.addWatchlist(testMovieDetail),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: "Failed",
        ),
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should update watchlist status when remove watchlist success',
      build: () {
        when(remove.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(status.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.removeWatchlist(testMovieDetail),
      verify: (cubit) => cubit.removeWatchlist(testMovieDetail),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: "Removed from Watchlist",
          saveErrorMessage: null,
        ),
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should show error when remove watchlist failed',
      build: () {
        when(remove.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(status.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.removeWatchlist(testMovieDetail),
      verify: (cubit) => cubit.removeWatchlist(testMovieDetail),
      expect: () => [
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: "Failed",
        ),
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          movie: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );
  });
}
