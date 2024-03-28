part of 'explore_bloc.dart';

abstract class ExploreState {
  final bool visible;
  final double opacity;
  final String statusMessage;
  final String query;
  ExploreState({
    required this.visible,
    required this.opacity,
    required this.statusMessage,
    required this.query,
  });
}

class ExploreInitial extends ExploreState {
  ExploreInitial({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
    required super.query,
  });
}

class ExploreSuccess extends ExploreState {
  ExploreSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
    required super.query,
  });
}

class ExploreClearSuccess extends ExploreState {
  ExploreClearSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
    required super.query,
  });
}
