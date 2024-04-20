part of 'explore_bloc.dart';

abstract class ExploreState {
  final int indexPageExplore;
  final bool visible;
  final double opacity;
  final String statusMessage;
  final String query;
  final bool enabledSearch;
  ExploreState({
    required this.indexPageExplore,
    required this.visible,
    required this.opacity,
    required this.statusMessage,
    required this.query,
    required this.enabledSearch,
  });
}

class ExploreInitial extends ExploreState {
  ExploreInitial({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
    required super.query,
    required super.enabledSearch,
    required super.indexPageExplore,
  });
}


class ExploreSuccess extends ExploreState {
  ExploreSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
    required super.query,
    required super.enabledSearch,
    required super.indexPageExplore,
  });
}

class ExploreSearchSuccess extends ExploreState {
  ExploreSearchSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
    required super.query,
    required super.enabledSearch,
    required super.indexPageExplore,
  });
}
