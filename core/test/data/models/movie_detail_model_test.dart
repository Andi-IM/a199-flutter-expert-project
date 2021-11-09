import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieDetailModel = MovieDetailResponse(
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
  const tMovieDetail = MovieDetail(
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
  final tMovieDetailMap = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 10,
    'genres': [{'id': 1, 'name': 'Action'}],
    'homepage': 'homepage',
    'id': 1,
    'imdb_id': '1',
    'original_language': 'en',
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 100.0,
    'poster_path': 'posterPath',
    'release_date': '2020-02-02',
    'revenue': 10,
    'runtime': 1,
    'status': 'released',
    'tagline': 'tagline',
    'title': 'title',
    'video': false,
    'vote_average': 1.0,
    'vote_count': 1
  };

  group('Movie Detail',(){
    test('should be a subclass of MovieDetail entity', () async {
      final result = tMovieDetailModel.toEntity();
      expect(result, tMovieDetail);
    });

    test('should be a valid json',() async {
      final result = tMovieDetailModel.toJson();
      expect(result, tMovieDetailMap);
    });

    test('should be a subclass MovieDetail valid json',() async {
      final result = MovieDetailResponse.fromJson(tMovieDetailMap);
      expect(result, tMovieDetailModel);
    });
  });
}
