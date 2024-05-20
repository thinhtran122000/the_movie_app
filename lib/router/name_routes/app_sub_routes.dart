import 'package:tmdb/router/router.dart';

class AppSubRoutes {
  // Sub routes Exlore Page
  static const String discovery = '${AppMainRoutes.explore}/discovery';
  static const String search = '${AppMainRoutes.explore}/search';
  // Sub routes Discovery View

  static const String browse = '$discovery/browse';
  static const String streaming = '$discovery/streaming';
  static const String comingSoon = '$discovery/coming_soon';
  static const String inTheaters = '$discovery/in_theaters';
  // Sub routes Profile Page
  static const String general = '${AppMainRoutes.profile}/general';
  static const String settings = '${AppMainRoutes.profile}/settings';
  static const String account = '${AppMainRoutes.profile}/account';
  static const String display = '${AppMainRoutes.profile}/display';
  static const String notifications = '${AppMainRoutes.profile}/notifications';
  static const String history = '${AppMainRoutes.profile}/history';
  static const String about = '${AppMainRoutes.profile}/about';
}
