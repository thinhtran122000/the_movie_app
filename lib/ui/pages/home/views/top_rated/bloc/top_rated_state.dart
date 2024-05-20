part of 'top_rated_bloc.dart';

class TopRatedState {
  final List<MultipleMedia> listTopRated;
  final List<MediaState> listState;
  final String statusMessage;
  final int index;
  TopRatedState({
    required this.listTopRated,
    required this.listState,
    required this.statusMessage,
    required this.index,
  });
}

class TopRatedInitial extends TopRatedState {
  TopRatedInitial({
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedSuccess extends TopRatedState {
  TopRatedSuccess({
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedAddWatchlistSuccess extends TopRatedState {
  TopRatedAddWatchlistSuccess({
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedAddWatchlistError extends TopRatedState {
  final String errorMessage;
  TopRatedAddWatchlistError({
    required this.errorMessage,
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedAddFavoritesSuccess extends TopRatedState {
  TopRatedAddFavoritesSuccess({
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedAddFavoritesError extends TopRatedState {
  final String errorMessage;
  TopRatedAddFavoritesError({
    required this.errorMessage,
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedError extends TopRatedState {
  final String errorMessage;
  TopRatedError({
    required this.errorMessage,
    required super.listTopRated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
