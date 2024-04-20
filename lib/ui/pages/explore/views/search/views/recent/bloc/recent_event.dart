part of 'recent_bloc.dart';

class RecentEvent {}

class FetchData extends RecentEvent {
  final String query;
  final bool includeAdult;
  final String language;
  final String mediaType;
  final String timeWindow;
  final bool isSearching;
  FetchData({
    required this.query,
    required this.includeAdult,
    required this.language,
    required this.mediaType,
    required this.timeWindow,
    required this.isSearching,
  });
}

class LoadMore extends RecentEvent {
  final String query;
  final bool includeAdult;
  final String language;
  final String mediaType;
  final String timeWindow;
  LoadMore({
    required this.query,
    required this.includeAdult,
    required this.language,
    required this.mediaType,
    required this.timeWindow,
  });
}



class LoadShimmer extends RecentEvent {}
