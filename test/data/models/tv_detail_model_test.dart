import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvDetailModel = TvDetailResponse(
    posterPath: 'posterPath',
    popularity: 5.0,
    id: 1,
    backdropPath: 'backdropPath',
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
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'aired',
    tagline: 'tagline',
    type: 'type',
  );

  final tTvDetail = TvDetail(
    posterPath: 'posterPath',
    popularity: 5.0,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 4.0,
    overview: 'overview',
    firstAirDate: '2020-02-02',
    originCountry: ['us'],
    genres: [Genre(id: 1, name: 'action')],
    originalLanguage: 'en',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of Tv Detail entity', () async {
    final result = tTvDetailModel.toEntity();
    expect(result, tTvDetail);
  });
}
