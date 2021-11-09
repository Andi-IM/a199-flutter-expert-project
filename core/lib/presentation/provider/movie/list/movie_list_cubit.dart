import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit() : super(MovieListInitial());
}
