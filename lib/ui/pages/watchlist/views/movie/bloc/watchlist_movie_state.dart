part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState {
  final List<MultipleMedia> listWatchList;
  final List<MediaState> listMovieState;
  final bool status;
  final String sortBy;
  final int index;
  final String statusMessage;
  WatchlistMovieState({
    required this.listWatchList,
    required this.listMovieState,
    required this.status,
    required this.sortBy,
    required this.index,
    required this.statusMessage,
  });
}

class WatchlistMovieInitial extends WatchlistMovieState {
  WatchlistMovieInitial({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listMovieState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistMovieSuccess extends WatchlistMovieState {
  WatchlistMovieSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listMovieState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistMovieSortSuccess extends WatchlistMovieState {
  WatchlistMovieSortSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listMovieState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistMovieRemoveSuccess extends WatchlistMovieState {
  WatchlistMovieRemoveSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listMovieState,
    required super.index,
    required super.statusMessage,
  });
}

class WatchlistMovieError extends WatchlistMovieState {
  final String errorMessage;
  WatchlistMovieError({
    required this.errorMessage,
    required super.listWatchList,
    required super.status,
    required super.sortBy,
    required super.listMovieState,
    required super.index,
    required super.statusMessage,
  });
}
