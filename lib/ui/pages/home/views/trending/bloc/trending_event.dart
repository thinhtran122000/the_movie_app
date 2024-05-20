part of 'trending_bloc.dart';

abstract class TrendingEvent {}

class FetchDataTrending extends TrendingEvent {
  final String mediaType;
  final String timeWindow;
  final int page;
  final String language;
  final bool includeAdult;

  FetchDataTrending({
    required this.mediaType,
    required this.timeWindow,
    required this.page,
    required this.language,
    required this.includeAdult,
  });
}

class AddWatchlist extends TrendingEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class AddFavorites extends TrendingEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}
