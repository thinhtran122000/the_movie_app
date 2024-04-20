import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class NavigationPage extends StatelessWidget {
  final int? indexPageNavigation;
  final int? indexPageExplore;
  final int? indexPageDicovery;
  const NavigationPage({
    this.indexPageNavigation,
    super.key,
    this.indexPageExplore,
    this.indexPageDicovery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()
        ..add(NavigatePage(
          indexPage: indexPageNavigation ?? 0,
        )),
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (context, state) async {
          final bloc = BlocProvider.of<NavigationBloc>(context);
          if (state is NavigationError) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return CustomDialog(
                  canPopDialog: false,
                  title: 'Opps!',
                  content: 'Your session has been expired.\nPlease login again !',
                  image: Lottie.asset(
                    AnimationsPath.pandaSleepAnimation.assetName,
                    repeat: true,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                  titleStyle: TextStyle(
                    color: blackColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  contentStyle: TextStyle(
                    color: darkBlueColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  titleSingleChoice: 'Log out',
                  singleChoiceStyle: TextStyle(
                    color: redColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  onTapSingleChoice: () {
                    bloc.add(LogoutForExpired());
                    Navigator.of(context).push(
                      AppPageRoute(
                        builder: (context) => const NavigationPage(),
                        begin: const Offset(-1, 0),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            backgroundColor: Colors.white,
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
                if (state is NavigationError) {
                  return const SizedBox();
                }
                return IndexedStack(
                  index: state.indexPage,
                  children: [
                    const HomePage(),
                    ExplorePage(
                      indexPageExplore: indexPageExplore,
                      indexPageDiscovery: indexPageDicovery,
                    ),
                    const FlutterLogo(),

                    const ProfilePage(),

                    // const ProfilePage(),
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
                  imagePath: IconsPath.favoriteIcon.assetName,
                  onTap: () => state.indexPage != 1
                      ? bloc.add(NavigatePage(indexPage: 1))
                      : bloc.add(ScrollTop()),
                ),
                CustomNavigationBarItem(
                  imagePath: IconsPath.searchIcon.assetName,
                  onTap: () => state.indexPage != 2
                      ? bloc.add(NavigatePage(indexPage: 2))
                      : bloc.add(ScrollTop()),
                ),
                CustomNavigationBarItem(
                  imagePath: IconsPath.profileIcon.assetName,
                  onTap: () => state.indexPage != 3 ? bloc.add(NavigatePage(indexPage: 3)) : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
