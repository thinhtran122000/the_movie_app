import 'package:bloc/bloc.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  GeneralBloc() : super(GeneralInitial()) {
    on<GeneralEvent>(
      (event, emit) {},
    );
  }
}
