import 'dart:convert';

import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    posterPath: "/path.jpg",
    popularity: 1.0,
    id: 1,
    backdropPath: "/path.jpg",
    voteAverage: 5.0,
    overview: "overview",
    firstAirDate: "2010-05-05",
    originCountry: ["US"],
    genreIds: [1, 2, 3, 4],
    originalLanguage: "en",
    voteCount: 1,
    name: "name",
    originalName: "original name",
  );

  const tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path.jpg",
            "popularity": 1.0,
            "id": 1,
            "backdrop_path": "/path.jpg",
            "vote_average": 5.0,
            "overview": "overview",
            "first_air_date": "2010-05-05",
            "origin_country": ["US"],
            "genre_ids": [1, 2, 3, 4],
            "original_language": "en",
            "vote_count": 1,
            "name": "name",
            "original_name": "original name",
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
