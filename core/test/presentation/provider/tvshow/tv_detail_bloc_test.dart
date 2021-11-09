import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_tv_watchlist_status.dart';
import 'package:core/domain/usecases/remove_tv_watchlist.dart';
import 'package:core/domain/usecases/save_tv_watchlist.dart';
import 'package:core/presentation/provider/tvshow/detail/tv_detail_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchlistStatus,
  RemoveTvWatchlist,
  SaveTvWatchlist,
])
void main() {
  late TvDetailCubit bloc;
  late MockGetTvDetail detail;
  late MockGetTvRecommendations recommendations;
  late MockGetTvWatchlistStatus status;
  late MockSaveTvWatchlist save;
  late MockRemoveTvWatchlist remove;

  setUp(() {
    detail = MockGetTvDetail();
    recommendations = MockGetTvRecommendations();
    status = MockGetTvWatchlistStatus();
    save = MockSaveTvWatchlist();
    remove = MockRemoveTvWatchlist();
    bloc = TvDetailCubit(
      detail,
      recommendations,
      status,
      save,
      remove,
    );
  });

  const tId = 1;
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
  final tTvs = <Tv>[tTv];

  test('state should be initial', () async {
    expect(bloc.state, TvDetailState.initialState());
  });

  group('Get Tv Detail', () {
    blocTest<TvDetailCubit, TvDetailState>(
      'should get data from the usecases',
      build: () {
        when(detail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(recommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return bloc;
      },
      act: (cubit) => cubit.getDetail(tId),
      expect: () => [
        const TvDetailState(
          isDetailLoading: true,
          isRecommendationLoading: true,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
        TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: true,
          isSaved: false,
          tv: testTvDetail,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
        TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: testTvDetail,
          recommendations: tTvs,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should return error when data is unsuccessful',
      build: () {
        when(detail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(recommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (cubit) => cubit.getDetail(tId),
      expect: () => [
        const TvDetailState(
          isDetailLoading: true,
          isRecommendationLoading: true,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: "Server Failure",
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<TvDetailCubit, TvDetailState>(
      'should get the watchlist status',
      build: () {
        when(status.execute(1)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.getSaveStatus(tId),
      expect: () => [
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should update save watchlist status when add watchlist success',
      build: () {
        when(save.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(status.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testTvDetail),
      verify: (cubit) => cubit.addWatchlist(testTvDetail),
      expect: () => [
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: "Added to Watchlist",
          saveErrorMessage: null,
        ),
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),

      ],
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should show error when add watchlist failed',
      build: () {
        when(save.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(status.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testTvDetail),
      verify: (cubit) => cubit.addWatchlist(testTvDetail),
      expect: () => [
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: "Failed",
        ),
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should update watchlist status when remove watchlist success',
      build: () {
        when(remove.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(status.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.removeWatchlist(testTvDetail),
      verify: (cubit) => cubit.removeWatchlist(testTvDetail),
      expect: () => [
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: "Removed from Watchlist",
          saveErrorMessage: null,
        ),
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should show error when remove watchlist failed',
      build: () {
        when(remove.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(status.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.removeWatchlist(testTvDetail),
      verify: (cubit) => cubit.removeWatchlist(testTvDetail),
      expect: () => [
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: "Failed",
        ),
        const TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          tv: null,
          recommendations: null,
          message: null,
          saveMessage: null,
          saveErrorMessage: null,
        ),
      ],
    );
  });
}