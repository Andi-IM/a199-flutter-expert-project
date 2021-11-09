import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: '2020-02-02',
    episodeCount: 12,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );
  const tSeason = Season(
    airDate: '2020-02-02',
    episodeCount: 12,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );
  final tSeasonMap = {
    'air_date': '2020-02-02',
    'episode_count': 12,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  group('Season Model', () {
    test('should be a subclass of Season entity', () async {
      final result = tSeasonModel.toEntity();
      expect(result, tSeason);
    });

    test('should be a valid json', () async {
      final result = tSeasonModel.toJson();
      expect(result, tSeasonMap);
    });

    test('should be a valid Genre entity', () async {
      final result = SeasonModel.fromJson(tSeasonMap);
      expect(result, tSeasonModel);
    });
  });
}
