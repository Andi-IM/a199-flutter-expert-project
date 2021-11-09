import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_state.dart';

class MoviePopularCubit extends Cubit<MoviePopularState> {
  MoviePopularCubit() : super(MoviePopularInitial());
}
