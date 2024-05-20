part of 'top_tv_bloc.dart';

abstract class TopTvEvent {}

class FetchDataTopTv extends TopTvEvent {
  final String language;
  final int page;
  FetchDataTopTv({
    required this.language,
    required this.page,
  });
}

class AddWatchlist extends TopTvEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class AddFavorites extends TopTvEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}
