import 'package:core/data/data_sources/db/database_helper.dart';
import 'package:core/data/data_sources/movie_local_data_source.dart';
import 'package:core/data/data_sources/movie_remote_data_source.dart';
import 'package:core/data/data_sources/tv_local_data_source.dart';
import 'package:core/data/data_sources/tv_remote_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
