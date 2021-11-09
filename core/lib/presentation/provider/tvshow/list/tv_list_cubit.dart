import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_state.dart';

class TvListCubit extends Cubit<TvListState> {
  TvListCubit() : super(TvListInitial());
}
