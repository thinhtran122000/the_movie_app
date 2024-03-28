import 'package:bloc/bloc.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc() : super(DiscoveryInitial()) {
    on<DiscoveryEvent>((event, emit) {});
  }
}
