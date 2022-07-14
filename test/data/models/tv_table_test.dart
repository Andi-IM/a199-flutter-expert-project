import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvTable = TvTable(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: '/path.jpg',
  );

  final tTv = Tv(
    posterPath: "/path.jpg",
    popularity: null,
    id: 1,
    backdropPath: null,
    voteAverage: null,
    overview: "overview",
    firstAirDate: null,
    originCountry: null,
    genreIds: null,
    originalLanguage: null,
    voteCount: null,
    name: "name",
    originalName: null,
  );

  final tTvDetail = TvDetail(
    posterPath: '/path.jpg',
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
    episodeRunTime: [10],
    seasons: [
      Season(
        airDate: '2020-02-02',
        episodeCount: 12,
        id: 11,
        name: 'name',
        overview: 'overview',
        posterPath: '/path.jpg',
        seasonNumber: 1,
      )
    ],
  );

  final tTvMap = {
    'id': 1,
    'overview': 'overview',
    'posterPath': '/path.jpg',
    'name': 'name',
  };

  final tTvModel = TvModel(
    posterPath: "/path.jpg",
    popularity: 1,
    id: 1,
    backdropPath: "backdropPath",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: "firstAirDate",
    originCountry: [],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
    genreIds: [1, 2, 3, 4],
  );

  group('Tv Table', () {
    test('should be a subclass of Tv Table', () async {
      final result = TvTable.fromEntity(tTvDetail);
      expect(result, tTvTable);
    });
    test('should be a subclass of Tv Table from map', () async {
      final result = TvTable.fromMap(tTvMap);
      expect(result, tTvTable);
    });
    test('should be a subclass of Tv Table from Entity', () async {
      final result = TvTable.fromDTO(tTvModel);
      expect(result, tTvTable);
    });
    test('should be a subclass of Tv entity', () async {
      final result = tTvTable.toEntity();
      expect(result, tTv);
    });
    test('should be a correct json', () {
      final result = tTvTable.toJson();
      expect(result, tTvMap);
    });
  });
}
