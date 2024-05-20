import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';

class DiscoverySubRoute {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppSubRoutes.browse: (context, settings) => const NavigationPage(
          indexPage: 1,
          indexViewExplore: 0,
          indexTabDiscovery: 0,
        ),
    AppSubRoutes.streaming: (context, settings) => const NavigationPage(
          indexPage: 1,
          indexViewExplore: 0,
          indexTabDiscovery: 1,
        ),
    AppSubRoutes.comingSoon: (context, settings) => const NavigationPage(
          indexPage: 1,
          indexViewExplore: 0,
          indexTabDiscovery: 2,
        ),
    AppSubRoutes.inTheaters: (context, settings) => const NavigationPage(
          indexPage: 1,
          indexViewExplore: 0,
          indexTabDiscovery: 3,
        ),
  };
}
