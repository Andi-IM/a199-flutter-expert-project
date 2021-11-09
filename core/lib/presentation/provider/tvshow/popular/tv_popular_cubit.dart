import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_state.dart';

class TvPopularCubit extends Cubit<TvPopularState> {
  TvPopularCubit() : super(TvPopularInitial());
}
