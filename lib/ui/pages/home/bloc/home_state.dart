part of 'home_bloc.dart';

abstract class HomeState {
  final bool visible;
  final double opacity;
  final String statusMessage;
  HomeState({
    required this.visible,
    required this.opacity,
    required this.statusMessage,
  });
}

class HomeInitial extends HomeState {
  HomeInitial({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
  });
}

class HomeSuccess extends HomeState {
  HomeSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
  });
}

class HomeDisableSuccess extends HomeState {
  HomeDisableSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
  });
}