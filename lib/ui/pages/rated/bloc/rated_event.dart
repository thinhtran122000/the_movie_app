part of 'rated_bloc.dart';

class RatedEvent {}

class NavigateTabRated extends RatedEvent {
  final int indexTab;
  NavigateTabRated({
    required this.indexTab,
  });
}
