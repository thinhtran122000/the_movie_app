import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/ui/pages/explore/views/discovery/views/browse/bloc/browse_bloc.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseBloc()..add(LoadViewBrowse()),
      child: BlocBuilder<BrowseBloc, BrowseState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<BrowseBloc>(context);
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final scrollDirection = bloc.scrollController.position.userScrollDirection;
              if (scrollDirection == ScrollDirection.forward) {
                showNavigationBar(context);
                return false;
              }
              if (scrollDirection == ScrollDirection.reverse) {
                hideNavigationBar(context);
                return false;
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: bloc.scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Flexible(
                    flex: 1,
                    child: MovieView(),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(height: 300.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}
