import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTvs(mockMovieRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = 'Game of Thrones';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTvs(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvs));
  });
}
