import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/ui.dart';

class ProfileSubRoutes {
  static Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    AppSubRoutes.general: (context, settings) => GeneralView(
          navigatorKey: NavigatorKey.profileKey,
        ),
    AppSubRoutes.settings: (context, settings) => SettingsView(
          navigatorKey: NavigatorKey.profileKey,
        ),
    AppSubRoutes.account: (context, settings) => AccountView(
          navigatorKey: NavigatorKey.profileKey,
        ),
    AppSubRoutes.display: (context, settings) => const SizedBox(),
    AppSubRoutes.notifications: (context, settings) => const SizedBox(),
    AppSubRoutes.history: (context, settings) => const SizedBox(),
    AppSubRoutes.about: (context, settings) => const SizedBox(),
  };
}
