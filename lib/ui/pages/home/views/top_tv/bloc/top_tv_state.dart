part of 'top_tv_bloc.dart';

abstract class TopTvState {
  final List<MultipleMedia> listTopTv;
  final List<MediaState> listState;
  final String statusMessage;
  final int index;
  TopTvState({
    required this.listTopTv,
    required this.listState,
    required this.statusMessage,
    required this.index,
  });
}

class TopTvInitial extends TopTvState {
  TopTvInitial({
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopTvSuccess extends TopTvState {
  TopTvSuccess({
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopTvAddWatchlistSuccess extends TopTvState {
  TopTvAddWatchlistSuccess({
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopTvAddWatchlistError extends TopTvState {
  final String errorMessage;
  TopTvAddWatchlistError({
    required this.errorMessage,
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopTvAddFavoritesSuccess extends TopTvState {
  TopTvAddFavoritesSuccess({
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopTvAddFavoritesError extends TopTvState {
  final String errorMessage;
  TopTvAddFavoritesError({
    required this.errorMessage,
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopTvError extends TopTvState {
  final String errorMessage;
  TopTvError({
    required this.errorMessage,
    required super.listTopTv,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
