import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';

class AppRouteGenerator {
  static Map<String, Widget Function(BuildContext, RouteSettings)> resolveMainRoutes() => {
        ...AuthenticationRoutes.routes,
        ...NavigationRoutes.routes,
        ...DetailsRoutes.routes,
        ...WatchlistRoutes.routes,
        ...FavoritetRoutes.routes,
        ...RatingRoutes.routes,
        ...RatedRoutes.routes,
      };

  static Route onGenerateMainRoute(RouteSettings settings) {
    Map<String, Widget Function(BuildContext, RouteSettings)> routes = resolveMainRoutes();
    try {
      if (routes[settings.name] != null) {
        return AppPageRoute(
          routeSettings: settings,
          builder: (context) => routes[settings.name]!(context, settings),
          begin: const Offset(1, 0),
        );
      }
      return MaterialPageRoute(
        builder: (context) => const SizedBox(),
        settings: settings,
      );
    } catch (e) {
      throw const FormatException("Route doesn't exist");
    }
  }

  static Map<String, Widget Function(BuildContext, RouteSettings)> resolveSubRoutes() => {
        ...ExploreSubRoute.routes,
        ...DiscoverySubRoute.routes,
        ...ProfileSubRoutes.routes,
      };

  static Route onGenerateSubRoute(RouteSettings settings) {
    Map<String, Widget Function(BuildContext, RouteSettings)> routes = resolveSubRoutes();
    try {
      if (routes[settings.name] != null) {
        return AppPageRoute(
          routeSettings: settings,
          builder: (context) => routes[settings.name]!(context, settings),
          begin: const Offset(1, 0),
        );
      }
      return MaterialPageRoute(
        builder: (context) => const SizedBox(),
        settings: settings,
      );
    } catch (e) {
      throw const FormatException("Sub route doesn't exist");
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:tmdb/router/router.dart';
// import 'package:tmdb/shared_ui/shared_ui.dart';
// import 'package:tmdb/ui/ui.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {

//       case RouteName.authentication:
//         {
//           final arguments = settings.arguments as Map<String, dynamic>?;
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => AuthenticationPage(
// isLaterLogin: arguments?['is_later_login'] as bool? ?? false,
// route: arguments?['route'] as String? ?? '',
//             ),
//             begin: const Offset(1, 0),
//           );
//         }

//       case RouteName.login:
//         {
//           final arguments = settings.arguments as Map<String, dynamic>?;
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => LoginPage(
//               route: arguments?['route'] as String? ?? '',
//             ),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.home:
//         {
//           final arguments = settings.arguments as Map<String, dynamic>?;
//           return arguments?['material_page_route'] == true
//               ? MaterialPageRoute(
//                   settings: settings,
//                   builder: (context) => const NavigationPage(indexPageNavigation: 0),
//                 )
//               : CustomPageRoute(
//                   routeSettings: settings,
//                   builder: (context) => const NavigationPage(indexPageNavigation: 0),
//                   begin: const Offset(1, 0),
//                 );
//         }
//       case RouteName.explore:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(indexPageNavigation: 1),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.trailer:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(indexPageNavigation: 2),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.profile:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(indexPageNavigation: 3),
//             begin: const Offset(1, 0),
//           );
//         }

//       case RouteName.search:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
// builder: (context) => const NavigationPage(
//   indexPageNavigation: 1,
//   indexPageExplore: 1,
// ),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.browse:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(
//               indexPageNavigation: 0,
//               indexPageExplore: 0,
//               indexPageDicovery: 0,
//             ),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.streaming:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(
//               indexPageNavigation: 0,
//               indexPageExplore: 0,
//               indexPageDicovery: 1,
//             ),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.comingSoon:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(
//               indexPageNavigation: 0,
//               indexPageExplore: 0,
//               indexPageDicovery: 2,
//             ),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.inTheaters:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const NavigationPage(
//               indexPageNavigation: 0,
//               indexPageExplore: 0,
//               indexPageDicovery: 3,
//             ),
//             begin: const Offset(1, 0),
//           );
//         }
//       case RouteName.settings:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const SettingPage(),
//             begin: const Offset(1, 0),
//           );
//         }
//       default:
//         {
//           return CustomPageRoute(
//             routeSettings: settings,
//             builder: (context) => const SizedBox(),
//             begin: const Offset(1, 0),
//           );
//         }
//     }
//   }
// }

