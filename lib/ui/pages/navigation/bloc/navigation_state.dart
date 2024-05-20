part of 'navigation_bloc.dart';

abstract class NavigationState {
  final int indexPage;
  final bool visible;
  NavigationState({
    required this.indexPage,
    required this.visible,
  });
}

class NavigationInitial extends NavigationState {
  NavigationInitial({
    required super.indexPage,
    required super.visible,
  });
}

class NavigationLoading extends NavigationState {
  NavigationLoading({
    required super.indexPage,
    required super.visible,
  });
}

class NavigationSuccess extends NavigationState {
  NavigationSuccess({
    required super.indexPage,
    required super.visible,
  });
}

class NavigationScrollSuccess extends NavigationState {
  NavigationScrollSuccess({
    required super.indexPage,
    required super.visible,
  });
}

class NavigationError extends NavigationState {
  NavigationError({
    required super.indexPage,
    required super.visible,
  });
}
