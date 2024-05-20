part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeAnimationToast extends HomeEvent {
  final double opacity;
  ChangeAnimationToast({
    required this.opacity,
  });
}

class DisplayToast extends HomeEvent {
  final bool visible;
  final String statusMessage;

  DisplayToast({
    required this.visible,
    required this.statusMessage,
  });
}

class DisableTrailer extends HomeEvent {}

class RefreshPage extends HomeEvent {}

