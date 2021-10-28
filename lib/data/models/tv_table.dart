import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  TvTable({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  final String? posterPath;
  final int id;
  final String? overview;
  final String? name;

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
        id: tv.id,
        overview: tv.overview,
        posterPath: tv.posterPath,
        name: tv.name,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        name: map['name'],
      );

  factory TvTable.fromDTO(TvModel tv) => TvTable(
        id: tv.id,
        overview: tv.overview,
        posterPath: tv.posterPath,
        name: tv.name,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'overview': overview,
        'posterPath': posterPath,
        'name': name,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        name,
      ];
}
