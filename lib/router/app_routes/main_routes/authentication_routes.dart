import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';

class AuthenticationRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppMainRoutes.login: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;
      return LoginPage(
        route: arguments?['route'] as String? ?? '',
      );
    },
    AppMainRoutes.authentication: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;
      return AuthenticationPage(
        isLaterLogin: arguments?['is_later_login'] as bool? ?? false,
        route: arguments?['route'] as String? ?? '',
      );
    }
  };
}
