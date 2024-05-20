part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent {}

class FetchData extends WatchlistTvEvent {
  final String language;
  String? sortBy;
  FetchData({
    required this.language,
    this.sortBy,
  });
}

class LoadMore extends WatchlistTvEvent {
  final String language;
  String? sortBy;
  LoadMore({
    required this.language,
    this.sortBy,
  });
}

class Sort extends WatchlistTvEvent {
  bool status;
  final String sortBy;
  Sort({
    required this.sortBy,
    required this.status,
  });
}

class RemoveWatchlist extends WatchlistTvEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  RemoveWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class LoadShimmer extends WatchlistTvEvent {}
