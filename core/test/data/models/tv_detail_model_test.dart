import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvDetailModel = TvDetailResponse(
    posterPath: '/path.jpg',
    popularity: 5.0,
    id: 1,
    backdropPath: '/path.jpg',
    voteAverage: 4.0,
    overview: 'overview',
    firstAirDate: '2020-02-02',
    originCountry: ['us'],
    genres: [GenreModel(id: 1, name: 'action')],
    originalLanguage: 'en',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
    episodeRunTime: [10],
    homepage: 'homepage',
    inProduction: false,
    lastAirDate: '2021-01-01',
    numberOfEpisodes: 24,
    numberOfSeasons: 1,
    seasons: [
      SeasonModel(
        airDate: '2020-02-02',
        episodeCount: 12,
        id: 12,
        name: 'name',
        overview: 'overview',
        posterPath: '/path.jpg',
        seasonNumber: 1,
      ),
    ],
    status: 'aired',
    tagline: 'tagline',
    type: 'type',
  );
  final tTvDetail = TvDetail(
    posterPath: '/path.jpg',
    popularity: 5.0,
    id: 1,
    backdropPath: '/path.jpg',
    voteAverage: 4.0,
    overview: 'overview',
    firstAirDate: '2020-02-02',
    originCountry: ['us'],
    genres: [Genre(id: 1, name: 'action')],
    originalLanguage: 'en',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
    episodeRunTime: [10],
    seasons: [
      SeasonModel(
        airDate: '2020-02-02',
        episodeCount: 12,
        id: 12,
        name: 'name',
        overview: 'overview',
        posterPath: '/path.jpg',
        seasonNumber: 1,
      )
    ],
  );
  final tTvDetailMap = {
    'backdrop_path': '/path.jpg',
    'episode_run_time': [10],
    'first_air_date': '2020-02-02',
    'origin_country': ['us'],
    'genres': [{'id': 1, 'name': 'action'}],
    'homepage': 'homepage',
    'id': 1,
    'in_production': false,
    'last_air_date': '2021-01-01',
    'name': 'name',
    'number_of_episodes': 24,
    'number_of_seasons': 1,
    'original_language': 'en',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 5.0,
    'poster_path': '/path.jpg',
    'seasons': [
      {
        'air_date': '2020-02-02',
        'episode_count': 12,
        'id': 12,
        'name': 'name',
        'overview': 'overview',
        'poster_path': '/path.jpg',
        'season_number': 1
      }
    ],
    'status': 'aired',
    'tagline': 'tagline',
    'type': 'type',
    'vote_average': 4.0,
    'vote_count': 1
  };

  group('Tv Detail', () {
    test('should be a subclass of Tv Detail entity', () async {
      final result = tTvDetailModel.toEntity();
      expect(result, tTvDetail);
    });

    test('should be a valid json', () async {
      final result = tTvDetailModel.toJson();
      expect(result, tTvDetailMap);
    });

    test('should be a valid TvDetail entity', () async {
      final result = TvDetailResponse.fromJson(tTvDetailMap);
      expect(result, tTvDetailModel);
    });
  });
}
