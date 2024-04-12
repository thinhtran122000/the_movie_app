part of 'login_bloc.dart';

class LoginState {
  final String statusMessage;
  final bool showPassword;
  final bool error;
  LoginState({
    required this.statusMessage,
    required this.showPassword,
    required this.error,
  });
}

class LoginInitial extends LoginState {
  LoginInitial({
    required super.showPassword,
    required super.statusMessage,
    required super.error,
  });
}

class LoginLoading extends LoginState {
  LoginLoading({
    required super.showPassword,
    required super.statusMessage,
    required super.error,
  });
}

class LoginLoaded extends LoginState {
  LoginLoaded({
    required super.showPassword,
    required super.statusMessage,
    required super.error,
  });
}

class LoginSuccess extends LoginState {
  LoginSuccess({
    required super.showPassword,
    required super.statusMessage,
    required super.error,
  });
}

class LoginError extends LoginState {
  LoginError({
    required super.showPassword,
    required super.statusMessage,
    required super.error,
  });
}
