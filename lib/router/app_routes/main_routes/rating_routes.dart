import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class RatingRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.rating: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;

      return RatingPage(
        id: arguments?['id'] as int?,
        title: arguments?['title'] as String?,
        imageUrl: arguments?['image_url'] as String?,
        value: arguments?['value'] as double?,
        mediaType: arguments?['media_type'] as MediaType?,
      );
    },
  };
}
