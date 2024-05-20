// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trending_bloc.dart';

abstract class TrendingState {
  final List<MultipleMedia> listTrending;
  final List<MediaState> listState;
  final String statusMessage;
  final int index;
  TrendingState({
    required this.listTrending,
    required this.listState,
    required this.statusMessage,
    required this.index,
  });
}

class TrendingInitial extends TrendingState {
  TrendingInitial({
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TrendingSuccess extends TrendingState {
  TrendingSuccess({
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TrendingAddWatchlistSuccess extends TrendingState {
  TrendingAddWatchlistSuccess({
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TrendingAddWatchlistError extends TrendingState {
  final String errorMessage;
  TrendingAddWatchlistError({
    required this.errorMessage,
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TrendingAddFavoritesSuccess extends TrendingState {
  TrendingAddFavoritesSuccess({
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TrendingAddFavoritesError extends TrendingState {
  final String errorMessage;
  TrendingAddFavoritesError({
    required this.errorMessage,
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class TrendingError extends TrendingState {
  final String errorMessage;
  TrendingError({
    required this.errorMessage,
    required super.listTrending,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
