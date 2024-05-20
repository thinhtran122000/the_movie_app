part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent {}

class FetchDataNowPlaying extends NowPlayingEvent {
  final String language;
  final int page;
  final bool fetchFeature;
  FetchDataNowPlaying({
    required this.language,
    required this.page,
    required this.fetchFeature,
  });
}

class AddFavorites extends NowPlayingEvent {
  final String mediaType;
  final int mediaId;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
  });
}
