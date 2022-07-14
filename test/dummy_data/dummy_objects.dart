import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTv = Tv(
  posterPath: "posterPath",
  popularity: 1,
  id: 1,
  backdropPath: "backdropPath",
  voteAverage: 1,
  overview: "overview",
  firstAirDate: "firstAirDate",
  originCountry: [],
  genreIds: [1, 2, 3],
  originalLanguage: "originalLanguage",
  voteCount: 1,
  name: "name",
  originalName: "originalName",
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  posterPath: 'posterPath',
  popularity: 100.0,
  id: 1,
  backdropPath: 'backdropPath',
  voteAverage: 1.0,
  overview: 'overview',
  firstAirDate: '2020-03-03',
  originCountry: ['US'],
  genres: [Genre(id: 1, name: 'action')],
  originalLanguage: 'JP',
  voteCount: 1,
  name: 'name',
  originalName: 'originalName',
  episodeRunTime: [1, 2, 3, 4],
  seasons: [
    Season(
      airDate: '2020-03-03',
      episodeCount: 12,
      id: 11,
      name: 'name',
      overview: 'overview',
      posterPath: '/path.jpg',
      seasonNumber: 1,
    )
  ],
);

final testTvCache = TvTable(
  id: 31917,
  name: 'Pretty Little Liars',
  overview:
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard',
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
);

final testTvCacheList = [testTvCache];

final testTvCacheMap = {
  'id': 31917,
  'name': 'Pretty Little Liars',
  'overview':
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard',
  'posterPath': '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
};

final testTvFromCache = Tv.watchlist(
  id: 31917,
  name: 'Pretty Little Liars',
  overview:
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard',
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
