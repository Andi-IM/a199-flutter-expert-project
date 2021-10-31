import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetTvWatchlistStatus {
  final MovieRepository repository;

  GetTvWatchlistStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToTvWatchlist(id);
  }
}