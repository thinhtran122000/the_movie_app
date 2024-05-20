part of 'rated_tv_bloc.dart';

class RatedTvState {
  final List<MultipleMedia> listRated;
  final List<MediaState> listTvState;
  final bool status;
  final String sortBy;
  final int index;
  final String statusMessage;
  RatedTvState({
    required this.listRated,
    required this.listTvState,
    required this.status,
    required this.sortBy,
    required this.index,
    required this.statusMessage,
  });
}

class RatedTvInitial extends RatedTvState {
  RatedTvInitial({
    required super.listRated,
    required super.listTvState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedTvSuccess extends RatedTvState {
  RatedTvSuccess({
    required super.listRated,
    required super.listTvState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedTvSortSuccess extends RatedTvState {
  RatedTvSortSuccess({
    required super.listRated,
    required super.listTvState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedTvAddWatchlistSuccess extends RatedTvState {
  RatedTvAddWatchlistSuccess({
    required super.listRated,
    required super.listTvState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedTvAddFavoritesSuccess extends RatedTvState {
  RatedTvAddFavoritesSuccess({
    required super.listRated,
    required super.listTvState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}

class RatedTvError extends RatedTvState {
  final String errorMessage;
  RatedTvError({
    required this.errorMessage,
    required super.listRated,
    required super.listTvState,
    required super.status,
    required super.sortBy,
    required super.index,
    required super.statusMessage,
  });
}
