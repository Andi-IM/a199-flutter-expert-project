import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvWatchlist {
  final TvRepository repository;

  GetTvWatchlist(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTvs();
  }
}
