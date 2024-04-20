import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/utils/app_key/app_key.dart';
import 'package:tmdb/utils/storage/secure_storage.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial(hasUser: false)) {
    on<LoadPageSettings>(_onLoadPageSettings);
  }

  FutureOr<void> _onLoadPageSettings(LoadPageSettings event, Emitter<SettingsState> emit) async {
    try {
      final accessToken = await SecureStorage().getValue(AppKeys.accessTokenKey);
      if (accessToken != null) {
        emit(SettingsSuccess(
          hasUser: true,
        ));
      } else {
        emit(SettingsSuccess(
          hasUser: false,
        ));
      }
    } catch (e) {
      emit(SettingsError(
        errorMessage: e.toString(),
        hasUser: state.hasUser,
      ));
    }
  }
}
