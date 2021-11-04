import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_on_the_air.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:core/domain/usecases/get_tv_watchlist.dart';
import 'package:core/domain/usecases/get_tv_watchlist_status.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_tv_watchlist.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_tv_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tvshow/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tvshow/tv_list_notifier.dart';
import 'package:core/presentation/provider/tvshow/tv_popular_notifier.dart';
import 'package:core/presentation/provider/tvshow/tv_top_rated_notifier.dart';
import 'package:core/presentation/provider/tvshow/tv_watchlist_notifier.dart';
import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvListProvider(
      getTvOnTheAir: locator(),
      getTvPopular: locator(),
      getTvTopRated: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getTvWatchlistStatus: locator(),
      saveTvWatchlist: locator(),
      removeTvWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularNotifier(
      getTvPopular: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedNotifier(
      getTvTopRated: locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistNotifier(
      getTvWatchlist: locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetTvWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
      () => TvRepositoryImpl(
        localDataSource: locator(),
        networkInfo: locator(),
        remoteDataSource: locator(),
      ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
