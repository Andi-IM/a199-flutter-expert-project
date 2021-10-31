import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genres,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final List<Genre> genres;
  final String overview;
  final String? firstAirDate;
  final List<String> originCountry;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        genres,
        overview,
        firstAirDate,
        originCountry,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
