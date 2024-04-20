import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/utils/utils.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  GeneralBloc() : super(GeneralInitial()) {
    on<LoadPageGeneral>(_onLoadPageGeneral);
    on<Logout>(_onLogout);
  }

  FutureOr<void> _onLoadPageGeneral(LoadPageGeneral event, Emitter<GeneralState> emit) async {
    final accessToken = await SecureStorage().getValue(AppKeys.accessTokenKey);
    if (accessToken != null) {
      emit(GeneralSuccess());
    } else {
      emit(GeneralLoaded());
    }
  }

  FutureOr<void> _onLogout(Logout event, Emitter<GeneralState> emit) async {
    await SecureStorage().deleteAllValues();
    print('Hello ${await SecureStorage().getAllValues()}');
    emit(GeneralSuccess());
  }
}
