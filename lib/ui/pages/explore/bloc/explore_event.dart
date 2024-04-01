// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'explore_bloc.dart';

abstract class ExploreEvent {}

class Search extends ExploreEvent {
  final String query;
  Search({
    required this.query,
  });
}

class Clear extends ExploreEvent {}

class MoveToSearch extends ExploreEvent {
  final bool enabledSearch;
  MoveToSearch({
    required this.enabledSearch,
  });
}

class ChangeAnimationToast extends ExploreEvent {
  final double opacity;
  ChangeAnimationToast({
    required this.opacity,
  });
}

class DisplayToast extends ExploreEvent {
  final bool visible;
  final String statusMessage;

  DisplayToast({
    required this.visible,
    required this.statusMessage,
  });
}
