import 'dart:async';

import 'package:bloc/bloc.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc()
      : super(WatchlistInitial(
          indexTab: 0,
        )) {
    on<NavigateTabWatchlist>(_onNavigateTabWatchlist);
  }

  FutureOr<void> _onNavigateTabWatchlist(NavigateTabWatchlist event, Emitter<WatchlistState> emit) {
    emit(WatchlistSuccess(
      indexTab: event.indexTab,
    ));
  }
}
