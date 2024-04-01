import 'dart:async';

import 'package:bloc/bloc.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc()
      : super(DiscoveryInitial(
          indexPage: 0,
        )) {
    on<NavigateTab>(_onNavigateTab);
  }

  FutureOr<void> _onNavigateTab(NavigateTab event, Emitter<DiscoveryState> emit) {
    emit(DiscoverySucess(
      indexPage: event.indexPage,
    ));
  }
}
