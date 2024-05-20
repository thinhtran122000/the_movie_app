import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/explore/explore.dart';
import 'package:tmdb/ui/pages/explore/views/discovery/bloc/discovery_bloc.dart';
import 'package:tmdb/ui/pages/explore/views/discovery/discovery.dart';

class DiscoveryView extends StatelessWidget {
  final int? indexTabDiscovery;
  const DiscoveryView({
    super.key,
    this.indexTabDiscovery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoveryBloc()
        ..add(NavigateTabDiscovery(
          indexTabDiscovery: indexTabDiscovery ?? 0,
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
                    textColor: state.indexTabDiscovery == 0 ? darkBlueColor : greyColor,
                    dividerColor: state.indexTabDiscovery == 0 ? darkBlueColor : Colors.transparent,
                    padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
                    onTapItem: () => state.indexTabDiscovery != 0
                        ? bloc.add(NavigateTabDiscovery(
                            indexTabDiscovery: 0,
                          ))
                        : null,
                  ),
                  CustomTabBarItem(
                    flex: 0,
                    title: 'Streaming',
                    backgroundColor: whiteColor,
                    textColor: state.indexTabDiscovery == 1 ? darkBlueColor : greyColor,
                    dividerColor: state.indexTabDiscovery == 1 ? darkBlueColor : Colors.transparent,
                    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                    onTapItem: () => state.indexTabDiscovery != 1
                        ? bloc.add(NavigateTabDiscovery(
                            indexTabDiscovery: 1,
                          ))
                        : null,
                  ),
                  CustomTabBarItem(
                    flex: 1,
                    title: 'Coming soon',
                    backgroundColor: whiteColor,
                    textColor: state.indexTabDiscovery == 2 ? darkBlueColor : greyColor,
                    dividerColor: state.indexTabDiscovery == 2 ? darkBlueColor : Colors.transparent,
                    onTapItem: () => state.indexTabDiscovery != 2
                        ? bloc.add(NavigateTabDiscovery(indexTabDiscovery: 2))
                        : null,
                  ),
                  CustomTabBarItem(
                    flex: 0,
                    title: 'In theaters',
                    backgroundColor: whiteColor,
                    textColor: state.indexTabDiscovery == 3 ? darkBlueColor : greyColor,
                    dividerColor: state.indexTabDiscovery == 3 ? darkBlueColor : Colors.transparent,
                    padding: EdgeInsets.fromLTRB(10.w, 0, 8.w, 0),
                    onTapItem: () => state.indexTabDiscovery != 3
                        ? bloc.add(NavigateTabDiscovery(indexTabDiscovery: 3))
                        : null,
                  ),
                ],
              ),
              Expanded(
                child: IndexedStack(
                  index: state.indexTabDiscovery,
                  children: const [
                    BrowseView(),
                    StreamingView(),
                    ComingSoonView(),
                    InTheatersView(),
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
