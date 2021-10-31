import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTvRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tTvs = <Tv>[];

  test('should get list of movie recommendations from the repository',
          () async {
        // arrange
        when(mockMovieRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTvs));
      });
}
