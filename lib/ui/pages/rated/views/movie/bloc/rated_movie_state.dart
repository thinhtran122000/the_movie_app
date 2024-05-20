part of 'rated_movie_bloc.dart';

class RatedMovieState {
  final List<MultipleMedia> listRated;
  final List<MediaState> listMovieState;
  final bool status;
  final String sortBy;
  final int index;
  final String statusMessage;
  RatedMovieState({
    required this.listRated,
    required this.listMovieState,
    required this.status,
    required this.sortBy,
    required this.index,
    required this.statusMessage,
  });
}

class RatedMovieInitial extends RatedMovieState {
  RatedMovieInitial({
    required super.listRated,
    required super.listMovieState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedMovieSuccess extends RatedMovieState {
  RatedMovieSuccess({
    required super.listRated,
    required super.listMovieState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedMovieSortSuccess extends RatedMovieState {
  RatedMovieSortSuccess({
    required super.listRated,
    required super.listMovieState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedMovieAddWatchlistSuccess extends RatedMovieState {
  RatedMovieAddWatchlistSuccess({
    required super.listRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
    required super.status,
    required super.sortBy,
  });
}

class RatedMovieAddFavoritesSuccess extends RatedMovieState {
  RatedMovieAddFavoritesSuccess({
    required super.listRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
    required super.status,
    required super.sortBy,
  });
}

class RatedMovieError extends RatedMovieState {
  final String errorMessage;
  RatedMovieError({
    required this.errorMessage,
    required super.listRated,
    required super.listMovieState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}
