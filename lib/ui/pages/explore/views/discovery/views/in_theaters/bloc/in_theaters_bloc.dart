import 'package:bloc/bloc.dart';

part 'in_theaters_event.dart';
part 'in_theaters_state.dart';

class InTheatersBloc extends Bloc<InTheatersEvent, InTheatersState> {
  InTheatersBloc() : super(InTheatersInitial()) {
    on<InTheatersEvent>((event, emit) {
    });
  }
}
