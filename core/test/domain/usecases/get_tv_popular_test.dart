import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetTvPopular(mockTvRpository);
  });

  final tTvs = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvRpository.getPopularTvs())
                .thenAnswer((_) async => Right(tTvs));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTvs));
          });
    });
  });
}
