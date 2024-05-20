import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/pages/favorite/favorite.dart';

class FavoritetRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.favorite: (context, settings) => const FavoritePage(),
  };
}
