import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class NavigationPage extends StatelessWidget {
  final int? indexPage;
  final int? indexViewExplore;
  final int? indexTabDiscovery;
  const NavigationPage({
    this.indexPage,
    super.key,
    this.indexViewExplore,
    this.indexTabDiscovery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()
        ..add(NavigatePage(
          indexPage: indexPage ?? 0,
        )),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            backgroundColor: whiteColor,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                if (state is NavigationInitial) {
                  return const Center(
                    child: CustomIndicator(
                      radius: 10,
                    ),
                  );
                }
                return IndexedStack(
                  index: state.indexPage,
                  children: [
                    const HomePage(),
                    ExplorePage(
                      indexViewExplore: indexViewExplore,
                      indexTabDiscovery: indexTabDiscovery,
                    ),
                    // const FlutterLogo(),
                    const ProfilePage(),
                  ],
                );
              },
            ),
            bottomNavigationBar: CustomNavigationBar(
              visible: state.visible,
              opacity: state.visible ? 1.0 : 0.0,
              background: BlurBackground(
                sigmaX: 3,
                sigmaY: 3,
                height: 60.h,
                paddingHorizontal: 25.w,
                radiusCorner: 30.r,
              ),
              margin: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, 23.h),
              padding: EdgeInsets.fromLTRB(23.w, 7.h, 23.w, 7.h),
              indexPage: state.indexPage,
              items: [
                CustomNavigationBarItem(
                  imagePath: IconsPath.homeIcon.assetName,
                  onTap: () => state.indexPage != 0
                      ? bloc.add(NavigatePage(indexPage: 0))
                      : bloc.add(ScrollTop()),
                ),
                CustomNavigationBarItem(
                  imagePath: IconsPath.searchIcon.assetName,
                  onTap: () => state.indexPage != 1
                      ? bloc.add(NavigatePage(indexPage: 1))
                      : bloc.add(ScrollTop()),
                ),
                // CustomNavigationBarItem(
                //   imagePath: IconsPath.favoriteIcon.assetName,
                //   onTap: () => state.indexPage != 2
                //       ? bloc.add(NavigatePage(indexPage: 2))
                //       : bloc.add(ScrollTop()),
                // ),
                CustomNavigationBarItem(
                  imagePath: IconsPath.profileIcon.assetName,
                  onTap: () => state.indexPage != 3
                      ? bloc.add(NavigatePage(indexPage: 2))
                      : bloc.add(ScrollTop()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
