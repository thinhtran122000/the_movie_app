import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:tmdb/utils/utils.dart';

part 'tmdb_event.dart';
part 'tmdb_state.dart';

class TmdbBloc extends Bloc<TmdbEvent, TmdbState> {
  TmdbBloc() : super(TmdbInitial()) {
    on<NotifyStateChange>(_onNotifyStateChange, transformer: droppable());
  }

  FutureOr<void> _onNotifyStateChange(NotifyStateChange event, Emitter<TmdbState> emit) async {
    switch (event.notificationTypes) {
      case NotificationTypes.favorites:
        emit(TmdbFavoritesSuccess());
        break;
      case NotificationTypes.watchlist:
        emit(TmdbWatchlistSuccess());
        break;
      case NotificationTypes.rating:
        emit(TmdbRatingSuccess());
        break;
      case NotificationTypes.login:
        emit(TmdbLoginSuccess());
        break;
      case NotificationTypes.logout:
        emit(TmdbLogoutSuccess());
        break;
      default:
        return;
    }
  }
}
