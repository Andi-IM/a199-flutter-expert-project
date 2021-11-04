import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:core/presentation/provider/tvshow/tv_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvPopular,
])
void main() {
  late MockGetTvPopular mockGetTvPopular;
  late TvPopularNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvPopular = MockGetTvPopular();
    notifier = TvPopularNotifier(
      getTvPopular: mockGetTvPopular,
    )..addListener(() {
        listenerCallCount++;
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

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvPopular.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });
  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvPopular.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
