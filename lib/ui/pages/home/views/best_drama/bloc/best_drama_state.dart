part of 'best_drama_bloc.dart';

abstract class BestDramaState {
  final List<MultipleMedia> listBestDrama;
  final List<MediaState> listState;
  final String statusMessage;
  final int index;
  BestDramaState({
    required this.listBestDrama,
    required this.listState,
    required this.statusMessage,
    required this.index,
  });
}

class BestDramaInitial extends BestDramaState {
  BestDramaInitial({
    required super.listBestDrama,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class BestDramaSuccess extends BestDramaState {
  BestDramaSuccess(
      {required super.listBestDrama,
      required super.listState,
      required super.statusMessage,
      required super.index});
}

class BestDramaAddWatchlistSuccess extends BestDramaState {
  BestDramaAddWatchlistSuccess({
    required super.listBestDrama,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class BestDramaAddWatchlistError extends BestDramaState {
  final String errorMessage;
  BestDramaAddWatchlistError({
    required this.errorMessage,
    required super.listBestDrama,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class BestDramaAddFavoritesSuccess extends BestDramaState {
  BestDramaAddFavoritesSuccess({
    required super.listBestDrama,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class BestDramaAddFavoritesError extends BestDramaState {
  final String errorMessage;
  BestDramaAddFavoritesError({
    required this.errorMessage,
    required super.listBestDrama,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class BestDramaError extends BestDramaState {
  final String errorMessage;
  BestDramaError({
    required this.errorMessage,
    required super.listBestDrama,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
