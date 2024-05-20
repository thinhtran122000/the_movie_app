import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/router/obsever/navigation_obsever.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: gainsBoroColor,
        appBar: CustomAppBar(
          appBarHeight: 30.h,
        ),
        body: NavigatorPopHandler(
          onPop: () {
            final obsever = AppNavigationObsever.profileObserver;
            if (obsever.history.last.settings.name == AppSubRoutes.general) {
              SystemNavigator.pop();
            } else {
              NavigatorKey.profileKey.currentState?.pop();
            }
          },
          child: Navigator(
            observers: [AppNavigationObsever.profileObserver],
            key: NavigatorKey.profileKey,
            initialRoute: AppSubRoutes.general,
            onGenerateRoute: AppRouteGenerator.onGenerateSubRoute,
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tmdb/router/router.dart';
// import 'package:tmdb/ui/pages/profile/bloc/profile_bloc.dart';
// import 'package:tmdb/ui/ui.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileBloc()..add(LoadPage()),
//       child: Scaffold(
//         appBar: CustomAppBar(
//           appBarHeight: 30.h,
//         ),
//         body: BlocConsumer<ProfileBloc, ProfileState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             final bloc = BlocProvider.of<ProfileBloc>(context);
//             if (state is ProfileLoaded) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushNamed(
//                           AppRoutes.authentication,
//                           arguments: {
//                             'is_later_login': true,
//                             'route': AppRoutes.profile,
//                           },
//                         ).then(
//                           (results) {
//                             if (results != null) {
//                               PopResults popResult = results as PopResults;
//                               if (popResult.toPage == AppRoutes.profile) {
//                                 // log('Hello ${popResult.results?.values.toList()}');
//                                 bloc.add(LoadPage());
//                               }
//                             }
//                           },
//                         );
//                       },
//                       child: const Text(
//                         'Login',
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(
//                       AppPageRoute(
//                         builder: (context) => const FavoritePage(),
//                         begin: const Offset(1, 0),
//                       ),
//                     ),
//                     child: const Text(
//                       'My Favorites',
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(
//                       AppPageRoute(
//                         builder: (context) => const WatchlistPage(),
//                         begin: const Offset(1, 0),
//                       ),
//                     ),
//                     child: const Text(
//                       'My Watchlist',
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pushNamed(
//                         AppRoutes.settings,
//                       );
//                     },
//                     // onTap: () async {
//                     //   await showDialog(
//                     //     context: context,
//                     //     barrierDismissible: true,
//                     //     builder: (dialogContext) {
//                     //       return CustomDialog(
//                     //         canPopDialog: true,
//                     //         enabledTitle: false,
//                     //         content: 'Sign out of TMDb?',
//                     //         isMultipleChoice: true,
//                     //         titleFirstChoice: 'Cancel',
//                     //         titleSecondChoice: 'OK',
//                     //         image: Lottie.asset(
//                     //           AnimationsPath.pandaSleepAnimation.assetName,
//                     //           repeat: true,
//                     //           width: 100.w,
//                     //           height: 100.h,
//                     //           fit: BoxFit.fill,
//                     //           filterQuality: FilterQuality.high,
//                     //         ),
//                     //         contentStyle: TextStyle(
//                     //           color: darkBlueColor,
//                     //           fontSize: 14.sp,
//                     //           fontWeight: FontWeight.bold,
//                     //           height: 1.5,
//                     //         ),
//                     //         firstChoiceStyle: TextStyle(
//                     //           color: blackColor,
//                     //           fontSize: 14.sp,
//                     //           fontWeight: FontWeight.bold,
//                     //         ),
//                     //         secondChoiceStyle: TextStyle(
//                     //           color: blackColor,
//                     //           fontSize: 14.sp,
//                     //         ),
//                     //         onTapFirstChoice: () => Navigator.of(dialogContext).pop(),
//                     //         onTapSecondChoice: () async {
//                     //           Navigator.of(dialogContext).pop();
//                     //           await Future.delayed(
//                     //             const Duration(seconds: 1),
//                     //             () => bloc.add(Logout()),
//                     //           ).then(
//                     //             (value) => Navigator.of(context).pushNamedAndRemoveUntil(
//                     //               '/navigation/home',
//                     //               arguments: {'material_page_route': true},
//                     //               (route) => false,
//                     //             ),
//                     //           );
//                     //         },
//                     //       );
//                     //     },
//                     //   );
//                     // },
//                     child: const Text(
//                       'Setting',
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
