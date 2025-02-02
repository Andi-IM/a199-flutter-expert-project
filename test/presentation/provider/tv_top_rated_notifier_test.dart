import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/presentation/provider/tv_top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvTopRated,
])
void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TvTopRatedNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvTopRated = MockGetTvTopRated();
    notifier = TvTopRatedNotifier(getTvTopRated: mockGetTvTopRated)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvModel =  Tv(
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
  final tTvList = <Tv>[tTvModel];

  group('Top Rated Notifier', (){
    test('should change state to loading when usecase is called',() async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      notifier.fetchTopRatedTvs();
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });
    test('should change tvs data when data is gotten successfully',() async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await notifier.fetchTopRatedTvs();
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.tvs, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful',() async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTopRatedTvs();
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
