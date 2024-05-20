import 'dart:async';
import 'package:bloc/bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(AuthenticationInitial(
          isLaterLogin: false,
        )) {
    on<LoadPageAuthentication>(_onLoadPageAuthentication);
  }

  FutureOr<void> _onLoadPageAuthentication(
      LoadPageAuthentication event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationLoaded(
      isLaterLogin: event.isLaterLogin,
    ));
  }
}
