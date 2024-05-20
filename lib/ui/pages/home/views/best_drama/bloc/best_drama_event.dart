part of 'best_drama_bloc.dart';

abstract class BestDramaEvent {}

class FetchDataBestDrama extends BestDramaEvent {
  final String language;
  final int page;
  final List<int> withGenres;
  FetchDataBestDrama({
    required this.language,
    required this.page,
    required this.withGenres,
  });
}

class AddWatchlist extends BestDramaEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}

class AddFavorites extends BestDramaEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}
