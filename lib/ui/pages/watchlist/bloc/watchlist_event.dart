part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {}

class NavigateTabWatchlist extends WatchlistEvent {
  final int indexTab;
  NavigateTabWatchlist({
    required this.indexTab,
  });
}