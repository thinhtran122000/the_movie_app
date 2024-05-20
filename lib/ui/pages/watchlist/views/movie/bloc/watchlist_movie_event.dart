part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent {}

class FetchData extends WatchlistMovieEvent {
  final String language;
  String? sortBy;
  FetchData({
    required this.language,
    this.sortBy,
  });
}

class LoadMore extends WatchlistMovieEvent {
  final String language;
  String? sortBy;
  LoadMore({
    required this.language,
    this.sortBy,
  });
}

class Sort extends WatchlistMovieEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.status,
    required this.sortBy,
  });
}

class RemoveWatchlist extends WatchlistMovieEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  RemoveWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class LoadShimmer extends WatchlistMovieEvent {}
