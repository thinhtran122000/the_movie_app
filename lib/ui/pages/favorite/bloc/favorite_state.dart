part of 'favorite_bloc.dart';

abstract class FavoriteState {
  final int indexTab;
  FavoriteState({
    required this.indexTab,
  });
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial({
    required super.indexTab,
  });
}
