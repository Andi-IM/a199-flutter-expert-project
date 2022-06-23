import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingMovies([testMovieCache]);
      // assert
      verify(mockDatabaseHelper.clearCache('now playing'));
      verify(mockDatabaseHelper
          .insertCacheTransaction([testMovieCache], 'now playing'));
    });
    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => [testMovieCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingMovies();
      // assert
      expect(result, [testMovieCache]);
    });
    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('save tv watchlist', (){
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.insertTvWatchlist(testTvTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertTvWatchlist(testTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove tv watchlist', (){
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeTvWatchlist(testTvTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeTvWatchlist(testTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get Tv Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('cache now airing tvs', (){
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearTvCache('on the air'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowAiringTvs([testTvCache]);
      // assert
      verify(mockDatabaseHelper.clearTvCache('on the air'));
      verify(mockDatabaseHelper
          .insertTvCacheTransaction([testTvCache], 'on the air'));
    });
    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvs('on the air'))
          .thenAnswer((_) async => [testTvCacheMap]);
      // act
      final result = await dataSource.getCachedNowAiringTvs();
      // assert
      expect(result, [testTvCache]);
    });
    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvs('on the air'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowAiringTvs();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('get watchlist tv', (){
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTvs();
      // assert
      expect(result, [testTvTable]);
    });
  });
}