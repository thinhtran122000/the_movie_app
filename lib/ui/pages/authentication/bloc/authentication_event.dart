part of 'authentication_bloc.dart';

class AuthenticationEvent {}

class LoadPageAuthentication extends AuthenticationEvent {
  final bool isLaterLogin;
  LoadPageAuthentication({
    required this.isLaterLogin,
  });
}

