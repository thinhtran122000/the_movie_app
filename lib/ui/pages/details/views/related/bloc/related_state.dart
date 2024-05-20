part of 'related_bloc.dart';

class RelatedState {
  final List<MultipleMedia> listRelated;
  final List<MediaState> listState;
  final String statusMessage;
  final int index;
  RelatedState({
    required this.listRelated,
    required this.listState,
    required this.statusMessage,
    required this.index,
  });
}

class RelatedInitial extends RelatedState {
  RelatedInitial({
    required super.listRelated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class RelatedSuccess extends RelatedState {
  RelatedSuccess({
    required super.listRelated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class RelatedAddWatchlistSuccess extends RelatedState {
  RelatedAddWatchlistSuccess({
    required super.listRelated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class RelatedAddWatchlistError extends RelatedState {
  final String errorMessage;
  RelatedAddWatchlistError({
    required this.errorMessage,
    required super.listRelated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}

class RelatedError extends RelatedState {
  final String errorMessage;
  RelatedError({
    required this.errorMessage,
    required super.listRelated,
    required super.listState,
    required super.statusMessage,
    required super.index,
  });
}
