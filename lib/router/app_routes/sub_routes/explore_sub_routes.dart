import 'package:flutter/material.dart';
import 'package:tmdb/router/name_routes/app_sub_routes.dart';
import 'package:tmdb/ui/ui.dart';

class ExploreSubRoute {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppSubRoutes.discovery: (context, settings) => const NavigationPage(
          indexPage: 1,
          indexViewExplore: 0,
        ),
    AppSubRoutes.search: (context, settings) => const NavigationPage(
          indexPage: 1,
          indexViewExplore: 1,
        ),
  };
}
