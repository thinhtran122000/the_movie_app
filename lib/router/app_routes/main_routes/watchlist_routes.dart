import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/pages/pages.dart';

class WatchlistRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.watchlist: (context, settings) => const WatchlistPage(),
  };
}
