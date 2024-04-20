import 'package:bloc/bloc.dart';

part 'coming_soon_event.dart';
part 'coming_soon_state.dart';

class ComingSoonBloc extends Bloc<ComingSoonEvent, ComingSoonState> {
  ComingSoonBloc() : super(ComingSoonInitial()) {
    on<ComingSoonEvent>((event, emit) {
    });
  }
}
