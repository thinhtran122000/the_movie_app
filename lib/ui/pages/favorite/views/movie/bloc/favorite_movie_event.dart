part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieEvent {}

class FetchData extends FavoriteMovieEvent {
  final String language;
  String? sortBy;
  FetchData({
    required this.language,
    this.sortBy,
  });
}

class LoadMore extends FavoriteMovieEvent {
  final String language;
  String? sortBy;
  LoadMore({
    required this.language,
    this.sortBy,
  });
}

class Sort extends FavoriteMovieEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.status,
    required this.sortBy,
  });
}

class AddWatchlist extends FavoriteMovieEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class LoadShimmer extends FavoriteMovieEvent {}
