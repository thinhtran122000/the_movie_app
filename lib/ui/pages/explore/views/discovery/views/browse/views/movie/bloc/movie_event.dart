part of 'movie_bloc.dart';

class MovieEvent {}

class FetchData extends MovieEvent {
  final String mediaType;
  final String timeWindow;
  final int page;
  final String language;
  final bool? includeAdult;
  final String? region;
  final List<int> withGenres;
  final String? timezone;

  FetchData({
    required this.mediaType,
    required this.page,
    required this.language,
    required this.timeWindow,
    this.includeAdult,
    this.region,
    this.withGenres = const [],
    this.timezone,
  });
}
