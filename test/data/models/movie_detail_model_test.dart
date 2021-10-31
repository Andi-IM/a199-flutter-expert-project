import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: '2020-02-02',
    runtime: 1,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
    video: false,
    originalLanguage: 'en',
    popularity: 100,
    tagline: 'tagline',
    revenue: 10,
    imdbId: '1',
    status: 'released',
    homepage: 'homepage',
    budget: 10,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: '2020-02-02',
    runtime: 1,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of MovieDetail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });
}
