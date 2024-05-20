part of 'rated_movie_bloc.dart';

class RatedMovieEvent {}

class FetchData extends RatedMovieEvent {
  final String language;
  String? sortBy;
  FetchData({
    required this.language,
    this.sortBy,
  });
}

class LoadMore extends RatedMovieEvent {
  final String language;
  String? sortBy;
  LoadMore({
    required this.language,
    this.sortBy,
  });
}

class Sort extends RatedMovieEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.status,
    required this.sortBy,
  });
}

class AddRating extends RatedMovieEvent {
  final int id;
  final double value;
  AddRating({
    required this.id,
    required this.value,
  });
}

class RemoveRating extends RatedMovieEvent {
  final int id;
  RemoveRating({
    required this.id,
  });
}

class AddFavorites extends RatedMovieEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class AddWatchlist extends RatedMovieEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class LoadShimmer extends RatedMovieEvent {}
