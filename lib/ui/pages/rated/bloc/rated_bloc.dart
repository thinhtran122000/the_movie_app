import 'dart:async';

import 'package:bloc/bloc.dart';

part 'rated_event.dart';
part 'rated_state.dart';

class RatedBloc extends Bloc<RatedEvent, RatedState> {
  RatedBloc()
      : super(RatedInitial(
          indexTab: 0,
        )) {
    on<NavigateTabRated>(_onNavigateTabRated);
  }

  FutureOr<void> _onNavigateTabRated(NavigateTabRated event, Emitter<RatedState> emit) {
    emit(RatedSuccess(
      indexTab: event.indexTab,
    ));
  }
}
