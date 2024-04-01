import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/pages/explore/views/search/bloc/search_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/search/views/recent/recent.dart';
import 'package:movie_app/ui/ui.dart';

class SearchView extends StatelessWidget {
  final String query;
  const SearchView({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Stack(
        children: [
          const IndexedStack(
            index: 0,
            children: [
              RecentView(),
            ],
          ),
          query.isEmpty
              ? CustomTabBar(
                  backgroundColor: whiteColor,
                  height: 40.h,
                  tabs: [
                    CustomTabBarItem(
                      flex: 0,
                      title: 'Recent',
                      backgroundColor: whiteColor,
                      textColor: darkBlueColor,
                      dividerColor: darkBlueColor,
                      padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
                      onTapItem: () {},
                    ),
                    CustomTabBarItem(
                      flex: 0,
                      title: 'Advanced Search',
                      backgroundColor: whiteColor,
                      textColor: greyColor,
                      dividerColor: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                      onTapItem: () {},
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
