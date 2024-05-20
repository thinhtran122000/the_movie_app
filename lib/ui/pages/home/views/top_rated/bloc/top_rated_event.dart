part of 'top_rated_bloc.dart';

class TopRatedEvent {}

class FetchDataTopRated extends TopRatedEvent {
  final int page;
  final String language;
  final String region;
  FetchDataTopRated({
    required this.page,
    required this.language,
    required this.region,
  });
}

class AddWatchlist extends TopRatedEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class AddFavorites extends TopRatedEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}
