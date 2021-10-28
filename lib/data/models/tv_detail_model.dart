import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable{
  TvDetailResponse({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final LastEpisodeToAir lastEpisodeToAir;
  final String name;
  final dynamic nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<Season> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) => TvDetailResponse(
    backdropPath: json["backdrop_path"],
    createdBy: List<CreatedBy>.from(json["created_by"].map((x) => CreatedBy.fromJson(x))),
    episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
    firstAirDate: DateTime.parse(json["first_air_date"]),
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    lastAirDate: DateTime.parse(json["last_air_date"]),
    lastEpisodeToAir: LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
    "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
    "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "last_air_date": "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
    "last_episode_to_air": lastEpisodeToAir.toJson(),
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    backdropPath,

  ];
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    creditId: json["credit_id"],
    name: json["name"],
    gender: json["gender"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "credit_id": creditId,
    "name": name,
    "gender": gender,
    "profile_path": profilePath,
  };
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  DateTime airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  String stillPath;
  double voteAverage;
  int voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => LastEpisodeToAir(
    airDate: DateTime.parse(json["air_date"]),
    episodeNumber: json["episode_number"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    productionCode: json["production_code"],
    seasonNumber: json["season_number"],
    stillPath: json["still_path"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "air_date": "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "id": id,
    "name": name,
    "overview": overview,
    "production_code": productionCode,
    "season_number": seasonNumber,
    "still_path": stillPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class Network {
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String name;
  int id;
  String logoPath;
  String originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    name: json["name"],
    id: json["id"],
    logoPath: json["logo_path"] == null ? null : json["logo_path"],
    originCountry: json["origin_country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "logo_path": logoPath == null ? null : logoPath,
    "origin_country": originCountry,
  };
}


class Season {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  DateTime airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    airDate: DateTime.parse(json["air_date"]),
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
  );

  Map<String, dynamic> toJson() => {
    "air_date": "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
  };
}
