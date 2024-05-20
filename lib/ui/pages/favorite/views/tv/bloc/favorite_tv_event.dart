part of 'favorite_tv_bloc.dart';

abstract class FavoriteTvEvent {}

class FetchData extends FavoriteTvEvent {
  final String language;
  String? sortBy;
  FetchData({
    required this.language,
    this.sortBy,
  });
}

class LoadMore extends FavoriteTvEvent {
  final String language;
  String? sortBy;
  LoadMore({
    required this.language,
    this.sortBy,
  });
}

class Sort extends FavoriteTvEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.sortBy,
    required this.status,
  });
}

class AddWatchlist extends FavoriteTvEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class LoadShimmer extends FavoriteTvEvent {}
