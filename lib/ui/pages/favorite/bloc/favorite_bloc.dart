import 'dart:async';

import 'package:bloc/bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc()
      : super(FavoriteInitial(
          indexTab: 0,
        )) {
    on<NavigateTabFavorite>(_onNavigateTabFavorite);
  }

  FutureOr<void> _onNavigateTabFavorite(NavigateTabFavorite event, Emitter<FavoriteState> emit) {
    emit(FavoriteInitial(
      indexTab: event.indexTab,
    ));
  }
}
