part of 'favorite_tv_bloc.dart';

abstract class FavoriteTvState {
  final List<MultipleMedia> listFavorite;
  final List<MediaState> listState;
  final bool status;
  final String sortBy;
  final String statusMessage;
  final int index;
  FavoriteTvState({
    required this.listFavorite,
    required this.listState,
    required this.status,
    required this.sortBy,
    required this.statusMessage,
    required this.index,
  });
}

class FavoriteTvInitial extends FavoriteTvState {
  FavoriteTvInitial({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class FavoriteTvSuccess extends FavoriteTvState {
  FavoriteTvSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class FavoriteTvSortSuccess extends FavoriteTvState {
  FavoriteTvSortSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class FavoriteTvAddWatchlistSuccess extends FavoriteTvState {
  FavoriteTvAddWatchlistSuccess({
    required super.listFavorite,
    required super.listState,
    required super.statusMessage,
    required super.index,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteTvAddWatchlistError extends FavoriteTvState {
  final String errorMessage;
  FavoriteTvAddWatchlistError({
    required this.errorMessage,
    required super.listFavorite,
    required super.listState,
    required super.statusMessage,
    required super.index,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteTvError extends FavoriteTvState {
  final String errorMessage;
  FavoriteTvError({
    required this.errorMessage,
    required super.listFavorite,
    required super.status,
    required super.sortBy,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
