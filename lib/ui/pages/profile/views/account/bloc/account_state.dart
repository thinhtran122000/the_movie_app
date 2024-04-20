part of 'account_bloc.dart';

class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoaded extends AccountState {}

class AccountSuccess extends AccountState {}

class AccountError extends AccountState {
  final String errorMessage;
  AccountError({
    required this.errorMessage,
  });
}
