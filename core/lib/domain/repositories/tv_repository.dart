import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs();
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTvs(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tv);
  Future<bool> isAddedToTvWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
}