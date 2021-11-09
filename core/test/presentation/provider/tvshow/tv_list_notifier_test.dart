import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_on_the_air.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:core/presentation/provider/tvshow/list/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvOnTheAir,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late TvListProvider provider;
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    provider = TvListProvider(
      getTvOnTheAir: mockGetTvOnTheAir,
      getTvPopular: mockGetTvPopular,
      getTvTopRated: mockGetTvTopRated,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv =  Tv(
    posterPath: "posterPath",
    popularity: 1,
    id: 1,
    backdropPath: "backdropPath",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: "firstAirDate",
    originCountry: [],
    genreIds: [1, 2, 3],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
  );

  final tTvList = <Tv>[tTv];

  group('On The Air Tvs', (){
    test('initialState should be Empty',(){
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });
    test('should get data from the usecases',(){
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTvs();
      // assert
      verify(mockGetTvOnTheAir.execute());
    });
    test('should change state to Loading when usecases is called',() async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTvs();
      // assert
      expect(provider.onTheAirState, equals(RequestState.Loading));
    });
    test('should change tvs when data is gotten successfully',() async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async  => Right(tTvList));
      // act
      await provider.fetchOnTheAirTvs();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTvs, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful',() async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTvs();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  group('Popular Tvs', (){
    test('should change state to loading when usecases is called',() async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async  => Right(tTvList));
      // act
      provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvsState, RequestState.Loading);
    });
    test('should change tvs data when data is gotten successfully',() async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvsState, RequestState.Loaded);
      expect(provider.popularTvs, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful',() async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  group('Top Rated Tvs', (){
    test('should change state to loading when usecases is called',() async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvsState, RequestState.Loading);
    });
    test('should change tvs data when data is gotten successfully',() async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvsState, RequestState.Loaded);
      expect(provider.topRatedTvs, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful',() async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
