import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';

class ProfileSubRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppSubRoutes.general: (context, settings) => GeneralView(
          navigatorKey: NavigatorKey.profileKey,
        ),
    AppSubRoutes.settings: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;
      return SettingsView(
        id: arguments?['id'] as int?,
        username: arguments?['username'] as String?,
        hasAccount: arguments?['has_account'] as bool?,
        navigatorKey: NavigatorKey.profileKey,
      );
    },
    AppSubRoutes.account: (context, settings) {
      final arguments = settings.arguments as Map<String, dynamic>?;
      return AccountView(
        id: arguments?['id'] as int?,
        username: arguments?['username'] as String?,
        navigatorKey: NavigatorKey.profileKey,
      );
    },
    AppSubRoutes.display: (context, settings) => const SizedBox(),
    AppSubRoutes.notifications: (context, settings) => const SizedBox(),
    AppSubRoutes.history: (context, settings) => const SizedBox(),
    AppSubRoutes.about: (context, settings) => const SizedBox(),
  };
}
