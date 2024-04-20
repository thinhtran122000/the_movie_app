import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/utils/utils.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          NavigationInitial(
            visible: true,
            indexPage: 0,
          ),
        ) {
    on<NavigatePage>(_onNavigatePage);
    on<ShowHide>(_onShowHide);
    on<ScrollTop>(_onScrollTop);
    on<LogoutForExpired>(_onLogoutForExpired);
  }

  FutureOr<void> _onNavigatePage(NavigatePage event, Emitter<NavigationState> emit) async {
    final accessToken = await SecureStorage().getValue(AppKeys.accessTokenKey);
    final expiresAt = await SecureStorage().getValue(AppKeys.expiresAtKey);
    if (accessToken != null) {
      if (expiresAt != null) {
        if (JwtDecoder.isExpired(expiresAt)) {
          emit(NavigationError(
            visible: state.visible,
            indexPage: state.indexPage,
          ));
        } else {
          emit(NavigationSuccess(
            visible: state.visible,
            indexPage: event.indexPage,
          ));
        }
      } else {
        emit(NavigationSuccess(
          visible: state.visible,
          indexPage: event.indexPage,
        ));
      }
    } else {
      emit(NavigationSuccess(
        visible: state.visible,
        indexPage: event.indexPage,
      ));
    }
  }

  FutureOr<void> _onShowHide(ShowHide event, Emitter<NavigationState> emit) {
    emit(NavigationSuccess(
      visible: event.visible,
      indexPage: state.indexPage,
    ));
  }

  FutureOr<void> _onScrollTop(ScrollTop event, Emitter<NavigationState> emit) {
    emit(NavigationScrollSuccess(
      visible: state.visible,
      indexPage: state.indexPage,
    ));
  }

  FutureOr<void> _onLogoutForExpired(LogoutForExpired event, Emitter<NavigationState> emit) async {
    await SecureStorage().deleteAllValues();
    print('Hello ${await SecureStorage().getAllValues()}');

    emit(NavigationScrollSuccess(
      visible: state.visible,
      indexPage: state.indexPage,
    ));
  }
}
