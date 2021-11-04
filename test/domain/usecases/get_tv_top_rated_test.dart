import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvTopRated usecase;
  late MockTvRepository mockMovieTv;

  setUp(() {
    mockMovieTv = MockTvRepository();
    usecase = GetTvTopRated(mockMovieTv);
  });

  final tTvs = <Tv>[];

  test('should get list of tvs from repository', () async {
    // arrange
    when(mockMovieTv.getTopRatedTvs())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
