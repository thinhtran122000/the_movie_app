import 'dart:async';

import 'package:bloc/bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<NotifyLogout>(_onNotifyLogout);
  }

  FutureOr<void> _onNotifyLogout(NotifyLogout event, Emitter<ProfileState> emit) {
    emit(ProfileSuccess());
  }
}
