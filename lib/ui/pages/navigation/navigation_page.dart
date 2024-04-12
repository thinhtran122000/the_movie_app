import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/ui/ui.dart';

class NavigationPage extends StatelessWidget {
  final bool? isLoginLater;
  const NavigationPage({
    this.isLoginLater = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()
        ..add(NavigatePage(
          indexPage: isLoginLater ?? false ? 3 : 0,
        )),
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (context, state) async {
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
                  onTapSingleChoice: () => Navigator.of(context).pushAndRemoveUntil(
                    CustomPageRoute(
                      page: const AuthenticationPage(),
                      begin: const Offset(-1, 0),
                    ),
                    (route) => false,
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: state.indexPage,
              children: const [
                HomePage(),
                ExplorePage(),
                ProfilePage(),
                ProfilePage(),
              ],
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
