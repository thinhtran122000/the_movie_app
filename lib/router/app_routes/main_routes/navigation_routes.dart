import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';

class NavigationRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.navigation: (context, settings) => const NavigationPage(),
    AppMainRoutes.home: (context, settings) => const NavigationPage(indexPageNavigation: 0),
    AppMainRoutes.explore: (context, settings) => const NavigationPage(indexPageNavigation: 1),
    AppMainRoutes.trailer: (context, settings) => const NavigationPage(indexPageNavigation: 2),
    AppMainRoutes.profile: (context, settings) => const NavigationPage(indexPageNavigation: 3),
  };
}
