part of 'watchlist_bloc.dart';

abstract class WatchlistState {
  final int indexTab;
  WatchlistState({
    required this.indexTab,
  });
}

class WatchlistInitial extends WatchlistState {
  WatchlistInitial({
    required super.indexTab,
  });
}

class WatchlistSuccess extends WatchlistState {
  WatchlistSuccess({
    required super.indexTab,
  });
}
