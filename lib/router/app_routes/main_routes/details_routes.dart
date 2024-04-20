import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';

class DetailsRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.details: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;
      return DetailsPage(
        id: arguments?['id'] as int? ?? 0,
        heroTag: arguments?['hero_tag'] as String? ?? '',
      );
    },
  };
}
