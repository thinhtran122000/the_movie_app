import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class DetailsRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.details: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;
      return DetailsPage(
        id: arguments?['id'] as int?,
        mediaType: arguments?['media_type'] as MediaType?,
        title: arguments?['title'] as String? ?? '',
        heroTag: arguments?['hero_tag'] as String? ?? '',
      );
    },
  };
}
