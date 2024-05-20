part of 'authentication_bloc.dart';

class AuthenticationState {
  final bool isLaterLogin;
  AuthenticationState({
    required this.isLaterLogin,
  });
}

class AuthenticationInitial extends AuthenticationState {
  AuthenticationInitial({
    required super.isLaterLogin,
  });
}

class AuthenticationLoaded extends AuthenticationState {
  AuthenticationLoaded({
    required super.isLaterLogin,
  });
}


class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess({
    required super.isLaterLogin,
  });
}

class AuthenticationError extends AuthenticationState {
  final String errorMessage;
  AuthenticationError({
    required this.errorMessage,
    required super.isLaterLogin,
  });
}
