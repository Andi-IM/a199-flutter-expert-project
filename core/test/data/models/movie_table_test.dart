import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: '/path.jpg',
    overview: 'overview',
  );

  final tMovie = Movie(
    adult: null,
    backdropPath: null,
    genreIds: null,
    id: 1,
    originalTitle: null,
    overview: 'overview',
    popularity: null,
    posterPath: '/path.jpg',
    releaseDate: null,
    title: 'title',
    video: null,
    voteAverage: null,
    voteCount: null,
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: null,
    id: 1,
    originalTitle: 'original title',
    overview: 'overview',
    posterPath: '/path.jpg',
    releaseDate: '2020-02-02',
    title: 'title',
    voteAverage: 4,
    voteCount: 5,
    genres: [],
    runtime: 1,
  );

  final tMovieMap = {
    'id': 1,
    'overview': 'overview',
    'posterPath': '/path.jpg',
    'title': 'title',
  };

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: null,
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: 'original title',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: null,
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Movie Table', () {
    test('should be a subclass of Movie Table', () async {
      final result = MovieTable.fromEntity(tMovieDetail);
      expect(result, tMovieTable);
    });

    test('should be a subclass of Movie Table from map', () async {
      final result = MovieTable.fromMap(tMovieMap);
      expect(result, tMovieTable);
    });

    test('should be a subclass of Movie Table from Entity', () async {
      final result = MovieTable.fromDTO(tMovieModel);
      expect(result, tMovieTable);
    });

    test('should be a subclass of Movie entity', () async {
      final result = tMovieTable.toEntity();
      expect(result, tMovie);
    });

    test('should be a correct json', () {
      final result = tMovieTable.toJson();
      expect(result, tMovieMap);
    });
  });
}
