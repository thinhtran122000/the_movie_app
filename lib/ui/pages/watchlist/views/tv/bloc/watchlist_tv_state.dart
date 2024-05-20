part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState {
  final List<MediaState> listTvState;
  final List<MultipleMedia> listWatchList;
  final bool status;
  final String sortBy;
  final int index;
  final String statusMessage;
  WatchlistTvState({
    required this.listTvState,
    required this.listWatchList,
    required this.status,
    required this.sortBy,
    required this.index,
    required this.statusMessage,
  });
}

class WatchlistTvInitial extends WatchlistTvState {
  WatchlistTvInitial({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listTvState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistTvSuccess extends WatchlistTvState {
  WatchlistTvSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listTvState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistTvSortSuccess extends WatchlistTvState {
  WatchlistTvSortSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listTvState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistTvRemoveSuccess extends WatchlistTvState {
  WatchlistTvRemoveSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listTvState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistTvError extends WatchlistTvState {
  final String errorMessage;
  WatchlistTvError({
    required this.errorMessage,
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listTvState,
    required super.index,
    required super.statusMessage,
  });
}
