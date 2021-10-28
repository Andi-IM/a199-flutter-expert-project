import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final tTvModel = TvModel(
      posterPath: "/path.jpg",
      popularity: 1.0,
      id: 1,
      backdropPath: "/path.jpg",
      voteAverage: 1.0,
      overview: "overview",
      firstAirDate: "2020-05-05",
      originCountry: ["originCountry"],
      genreIds: [1,2,3,4],
      originalLanguage: "id",
      voteCount: 1,
      name: "name",
      originalName: "originalName",
  );

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('formJson', (){

  });

  group('toJson', (){

  });
}