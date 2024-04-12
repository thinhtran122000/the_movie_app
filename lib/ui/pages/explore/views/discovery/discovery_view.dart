import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/explore.dart';
import 'package:movie_app/ui/pages/explore/views/discovery/bloc/discovery_bloc.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoveryBloc()
        ..add(NavigateTab(
          indexPage: 0,
        )),
      child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<DiscoveryBloc>(context);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTabBar(
                height: 40.h,
                backgroundColor: Colors.transparent,
                tabs: [
                  CustomTabBarItem(
                    flex: 0,
                    title: 'Browse',
                    backgroundColor: whiteColor,
                    textColor: state.indexPage == 0 ? darkBlueColor : greyColor,
                    dividerColor: state.indexPage == 0 ? darkBlueColor : Colors.transparent,
                    padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
                    onTapItem: () =>
                        state.indexPage != 0 ? bloc.add(NavigateTab(indexPage: 0)) : null,
                  ),
                  CustomTabBarItem(
                    flex: 0,
                    title: 'Streaming',
                    backgroundColor: whiteColor,
                    textColor: state.indexPage == 1 ? darkBlueColor : greyColor,
                    dividerColor: state.indexPage == 1 ? darkBlueColor : Colors.transparent,
                    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                    onTapItem: () =>
                        state.indexPage != 1 ? bloc.add(NavigateTab(indexPage: 1)) : null,
                  ),
                  CustomTabBarItem(
                    flex: 1,
                    title: 'Coming soon',
                    backgroundColor: whiteColor,
                    textColor: state.indexPage == 2 ? darkBlueColor : greyColor,
                    dividerColor: state.indexPage == 2 ? darkBlueColor : Colors.transparent,
                    onTapItem: () =>
                        state.indexPage != 2 ? bloc.add(NavigateTab(indexPage: 2)) : null,
                  ),
                  CustomTabBarItem(
                    flex: 0,
                    title: 'In theaters',
                    backgroundColor: whiteColor,
                    textColor: state.indexPage == 3 ? darkBlueColor : greyColor,
                    dividerColor: state.indexPage == 3 ? darkBlueColor : Colors.transparent,
                    padding: EdgeInsets.fromLTRB(10.w, 0, 8.w, 0),
                    onTapItem: () =>
                        state.indexPage != 3 ? bloc.add(NavigateTab(indexPage: 3)) : null,
                  ),
                ],
              ),
              Expanded(
                child: IndexedStack(
                  index: state.indexPage,
                  children: const [
                    BrowseView(),
                    FlutterLogo(),
                    FlutterLogo(),
                    FlutterLogo(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
