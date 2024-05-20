part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieState {
  final List<MultipleMedia> listFavorite;
  final List<MediaState> listState;
  final bool status;
  final String sortBy;
  final String statusMessage;
  final int index;
  FavoriteMovieState({
    required this.listFavorite,
    required this.listState,
    required this.status,
    required this.sortBy,
    required this.statusMessage,
    required this.index,
  });
}

class FavoriteMovieInitial extends FavoriteMovieState {
  FavoriteMovieInitial({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.statusMessage,
    required super.index,
    required super.listState,
  });
}

class FavoriteMovieSuccess extends FavoriteMovieState {
  FavoriteMovieSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.statusMessage,
    required super.index,
    required super.listState,
  });
}

class FavoriteMovieSortSuccess extends FavoriteMovieState {
  FavoriteMovieSortSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.statusMessage,
    required super.index,
    required super.listState,
  });
}

class FavoriteMovieAddWatchlistSuccess extends FavoriteMovieState {
  FavoriteMovieAddWatchlistSuccess({
    required super.listFavorite,
    required super.listState,
    required super.statusMessage,
    required super.index,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteMovieAddWatchlistError extends FavoriteMovieState {
  final String errorMessage;
  FavoriteMovieAddWatchlistError({
    required this.errorMessage,
    required super.listFavorite,
    required super.listState,
    required super.statusMessage,
    required super.index,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteMovieRemoveSuccess extends FavoriteMovieState {
  FavoriteMovieRemoveSuccess({
    required super.listFavorite,
    required super.listState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class FavoriteMovieError extends FavoriteMovieState {
  final String errorMessage;
  FavoriteMovieError({
    required this.errorMessage,
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
