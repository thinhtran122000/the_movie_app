import 'dart:async';

import 'package:bloc/bloc.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc()
      : super(DiscoveryInitial(
          indexTabDiscovery: 0,
        )) {
    on<NavigateTabDiscovery>(_onNavigateTab);
  }

  FutureOr<void> _onNavigateTab(NavigateTabDiscovery event, Emitter<DiscoveryState> emit) {
    emit(DiscoverySucess(
      indexTabDiscovery: event.indexTabDiscovery,
    ));
  }
}
