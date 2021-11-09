import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_state.dart';

class MovieTopRatedCubit extends Cubit<MovieTopRatedState> {
  MovieTopRatedCubit() : super(MovieTopRatedInitial());
}
