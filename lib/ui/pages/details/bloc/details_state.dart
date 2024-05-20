part of 'details_bloc.dart';

abstract class DetailsState {
  final MultipleDetails multipleDetails;
  final List<ImageResult> images;
  final MediaState? mediaState;
  final String statusMessage;
  final List<CreditResult> cast;
  final List<CreditResult> crew;

  DetailsState({
    required this.multipleDetails,
    required this.images,
    required this.statusMessage,
    required this.cast,
    required this.crew,
    this.mediaState,
  });
}

class DetailsInitial extends DetailsState {
  DetailsInitial({
    required super.multipleDetails,
    required super.images,
    super.mediaState,
    required super.statusMessage,
    required super.cast,
    required super.crew,
  });
}

class DetailsLoading extends DetailsState {
  DetailsLoading({
    required super.multipleDetails,
    required super.images,
    super.mediaState,
    required super.statusMessage,
    required super.cast,
    required super.crew,
  });
}

class DetailsLoaded extends DetailsState {
  DetailsLoaded({
    required super.multipleDetails,
    required super.images,
    super.mediaState,
    required super.statusMessage,
    required super.cast,
    required super.crew,
  });
}

class DetailsAddFavoriteSuccess extends DetailsState {
  DetailsAddFavoriteSuccess({
    required super.multipleDetails,
    required super.images,
    super.mediaState,
    required super.statusMessage,
    required super.cast,
    required super.crew,
  });
}

class DetailsAddWatchlistSuccess extends DetailsState {
  DetailsAddWatchlistSuccess({
    required super.multipleDetails,
    required super.images,
    super.mediaState,
    required super.statusMessage,
    required super.cast,
    required super.crew,
  });
}

class DetailsError extends DetailsState {
  final String errorMessage;
  DetailsError({
    required this.errorMessage,
    required super.multipleDetails,
    required super.images,
    super.mediaState,
    required super.statusMessage,
    required super.cast,
    required super.crew,
  });
}
