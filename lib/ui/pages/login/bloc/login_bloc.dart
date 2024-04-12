import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/ui.dart';
import 'package:movie_app/utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginRepository loginRepository = LoginRepository(restApiClient: RestApiClient());
  LoginBloc()
      : super(LoginInitial(
          showPassword: true,
          statusMessage: '',
          error: false,
        )) {
    on<ShowClearButton>(_onShowClearButton);
    on<ShowPassword>(_onShowPassword);
    on<Login>(_onLogin);
    on<LoadPage>(_onLoadPage);
  }

  FutureOr<void> _onShowClearButton(ShowClearButton event, Emitter<LoginState> emit) {
    if (state is LoginError) {
      emit(LoginError(
        statusMessage: state.statusMessage,
        showPassword: state.showPassword,
        error: state.error,
      ));
    } else {
      emit(LoginLoaded(
        showPassword: state.showPassword,
        statusMessage: state.statusMessage,
        error: state.error,
      ));
    }
  }

  FutureOr<void> _onLogin(Login event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading(
        showPassword: state.showPassword,
        statusMessage: state.statusMessage,
        error: false,
      ));
      await Future.delayed(const Duration(seconds: 2));
      if (AppValidation().validateAccount(event.username, event.password).isNotEmpty) {
        emit(LoginError(
          statusMessage: AppValidation().validateAccount(event.username, event.password),
          showPassword: state.showPassword,
          error: true,
        ));
      } else {
        final tokenResult = await loginRepository.refreshToken();
        final loginresult = await loginRepository.login(
          username: event.username,
          password: event.password,
          requestToken: tokenResult.object.requestToken ?? '',
        );
        if (loginresult.object.success == true) {
          emit(LoginSuccess(
            showPassword: state.showPassword,
            statusMessage: loginresult.object.statusMessage ?? '',
            error: false,
          ));
          SecureStorage()
              .setRequestToken(AppKeys.requestTokenKey, loginresult.object.requestToken ?? '');
          SecureStorage().setRequestToken(AppKeys.expiresAtKey, loginresult.object.expiresAt ?? '');
          log('${(await SecureStorage().getRequestToken(AppKeys.requestTokenKey))}');
          log('${(await SecureStorage().getRequestToken(AppKeys.expiresAtKey))}');
        } else {
          emit(LoginError(
            statusMessage: loginresult.object.statusMessage ?? '',
            showPassword: state.showPassword,
            error: false,
          ));
          print('Hello ${state.runtimeType}');
        }
      }
    } catch (e) {
      emit(LoginError(
        statusMessage: e.toString(),
        showPassword: state.showPassword,
        error: false,
      ));
    }
  }

  FutureOr<void> _onShowPassword(ShowPassword event, Emitter<LoginState> emit) {
    if (state is LoginError) {
      emit(LoginError(
        statusMessage: state.statusMessage,
        showPassword: !event.showPassword,
        error: state.error,
      ));
    } else {
      emit(LoginLoaded(
        statusMessage: state.statusMessage,
        showPassword: !event.showPassword,
        error: state.error,
      ));
    }
  }

  FutureOr<void> _onLoadPage(LoadPage event, Emitter<LoginState> emit) {
    emit(LoginLoaded(
      statusMessage: state.statusMessage,
      showPassword: state.showPassword,
      error: state.error,
    ));
  }
}
