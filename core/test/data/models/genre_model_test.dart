import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');
  final tGenre = Genre(id: 1, name: 'name');
  final tGenreMap = {
    'id' : 1,
    'name' : 'name',
  };

  group('Genre Model',(){
    test('should be a subclass of Genre entity', () async {
      final result = tGenreModel.toEntity();
      expect(result, tGenre);
    });

    test('should be a valid json', () async {
      final result = tGenreModel.toJson();
      expect(result, tGenreMap);
    });

    test('should be a valid Genre entity', () async {
      final result = GenreModel.fromJson(tGenreMap);
      expect(result, tGenreModel);
    });
  });
}