import 'package:bloc/bloc.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  TvBloc() : super(TvInitial()) {
    on<TvEvent>((event, emit) {});
  }
}
