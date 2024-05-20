part of 'now_playing_bloc.dart';

abstract class NowPlayingState {
  final MultipleDetails nowPlayingTv;
  final List<Color> paletteColors;
  final double averageLuminance;
  final MediaState? mediaState;
  final String statusMessage;
  NowPlayingState({
    required this.nowPlayingTv,
    required this.paletteColors,
    required this.averageLuminance,
    required this.mediaState,
    required this.statusMessage,
  });
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({
    required super.nowPlayingTv,
    required super.paletteColors,
    required super.averageLuminance,
    required super.mediaState,
    required super.statusMessage,
  });
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess({
    required super.paletteColors,
    required super.nowPlayingTv,
    required super.averageLuminance,
    required super.mediaState,
    required super.statusMessage,
  });
}

class NowPlayingAddFavoritesSuccess extends NowPlayingState {
  NowPlayingAddFavoritesSuccess({
    required super.nowPlayingTv,
    required super.paletteColors,
    required super.averageLuminance,
    required super.mediaState,
    required super.statusMessage,
  });
}

class NowPlayingAddFavoritesError extends NowPlayingState {
  final String errorMessage;
  NowPlayingAddFavoritesError({
    required this.errorMessage,
    required super.nowPlayingTv,
    required super.paletteColors,
    required super.averageLuminance,
    required super.mediaState,
    required super.statusMessage,
  });
}

class NowPlayingError extends NowPlayingState {
  final String errorMessage;
  NowPlayingError({
    required super.paletteColors,
    required this.errorMessage,
    required super.nowPlayingTv,
    required super.averageLuminance,
    required super.mediaState,
    required super.statusMessage,
  });
}
