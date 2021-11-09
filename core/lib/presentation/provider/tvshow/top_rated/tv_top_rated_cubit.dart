import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedCubit extends Cubit<TvTopRatedState> {
  TvTopRatedCubit() : super(TvTopRatedInitial());
}
