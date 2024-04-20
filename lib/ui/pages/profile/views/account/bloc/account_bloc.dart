import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/utils/storage/storage.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<Logout>(_onLogout);
    on<LoadPageAccount>(_onLoadPageAccount);
  }
  FutureOr<void> _onLoadPageAccount(LoadPageAccount event, Emitter<AccountState> emit) {
    emit(AccountLoaded());
  }

  FutureOr<void> _onLogout(Logout event, Emitter<AccountState> emit) async {
    try {
      await SecureStorage().deleteAllValues();
      print('Hello ${await SecureStorage().getAllValues()}');
      await Future.delayed(const Duration(seconds: 2));
      emit(AccountSuccess());
    } catch (e) {
      emit(AccountError(errorMessage: e.toString()));
    }
  }
}
