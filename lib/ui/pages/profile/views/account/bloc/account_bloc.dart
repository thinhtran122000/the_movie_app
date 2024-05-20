import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/ui/pages/pages.dart';
import 'package:tmdb/utils/rest_api_client/index.dart';
import 'package:tmdb/utils/storage/storage.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final ProfileRepository profileRepository = ProfileRepository(restApiClient: RestApiClient());
  AccountBloc() : super(AccountInitial()) {
    on<Logout>(_onLogout);
    on<FetchData>(_onFetchData);
  }
  FutureOr<void> _onFetchData(FetchData event, Emitter<AccountState> emit) async {
    try {
      emit(AccountLoaded());
    } catch (e) {
      emit(AccountError(
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onLogout(Logout event, Emitter<AccountState> emit) async {
    try {
      await FlutterStorage().deleteAllValues();
      print('Hello ${await FlutterStorage().getAllValues()}');
      await Future.delayed(const Duration(seconds: 2));
      emit(AccountSuccess());
    } catch (e) {
      emit(AccountError(
        errorMessage: e.toString(),
      ));
    }
  }
}
