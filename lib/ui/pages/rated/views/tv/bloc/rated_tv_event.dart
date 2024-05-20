part of 'rated_tv_bloc.dart';

class RatedTvEvent {}

class FetchData extends RatedTvEvent {
  final String language;
  String? sortBy;
  FetchData({
    required this.language,
    this.sortBy,
  });
}

class LoadMore extends RatedTvEvent {
  final String language;
  String? sortBy;
  LoadMore({
    required this.language,
    this.sortBy,
  });
}

class Sort extends RatedTvEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.status,
    required this.sortBy,
  });
}

class AddRating extends RatedTvEvent {
  final int id;
  final double value;
  AddRating({
    required this.id,
    required this.value,
  });
}

class RemoveRating extends RatedTvEvent {
  final int id;
  RemoveRating({
    required this.id,
  });
}

class AddFavorites extends RatedTvEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class AddWatchlist extends RatedTvEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class LoadShimmer extends RatedTvEvent {}
