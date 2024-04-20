part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class NavigateTabFavorite extends FavoriteEvent {
  final int indexTab;
  NavigateTabFavorite({
    required this.indexTab,
  });
}
