part of 'login_bloc.dart';

class LoginEvent {}

class LoadPageLogin extends LoginEvent {}

class ShowClearButton extends LoginEvent {}

class ShowPassword extends LoginEvent {
  final bool showPassword;
  ShowPassword({
    required this.showPassword,
  });
}

class Login extends LoginEvent {
  final String username;
  final String password;
  Login({
    required this.username,
    required this.password,
  });
}
