import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:tmdb/ui/pages/explore/explore.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';

class ExplorePage extends StatelessWidget {
  final int? indexPageDiscovery;
  final int? indexPageExplore;
  const ExplorePage({
    super.key,
    this.indexPageExplore,
    this.indexPageDiscovery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc()
        ..add(LoadPageExplore(
          indexPageExplore: indexPageExplore ?? 0,
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) => state is NavigationScrollSuccess ? reloadPage(context) : null,
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            print('Hello');
            final bloc = BlocProvider.of<ExploreBloc>(context);
            return Scaffold(
              backgroundColor: gainsBoroColor,
              appBar: CustomAppBar(
                appBarHeight: 80.h,
                customTitle: CustomTextField(
                  focusNode: bloc.focusNode,
                  controller: bloc.textController,
                  indexPageExplore: state.indexPageExplore,
                  focusedBorder: transparentRadiusBorder,
                  enabledBorder: transparentRadiusBorder,
                  hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                  margin: EdgeInsets.fromLTRB(13.w, 30.h, 13.w, 0),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  suffixIcon: bloc.textController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            bloc.focusNode.requestFocus();
                            bloc.add(Clear());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Icon(
                              Icons.clear,
                              color: darkBlueColor,
                              size: 24.sp,
                            ),
                          ),
                        )
                      : null,
                  onTap: state.indexPageExplore == 1
                      ? null
                      : () => bloc.add(LoadPageExplore(indexPageExplore: 1)),
                  onTapCancel: () {
                    bloc.add(LoadPageExplore(indexPageExplore: 0));
                    bloc.textController.text.isNotEmpty ? bloc.add(Clear()) : null;
                  },
                  onTapOutside: (event) => bloc.focusNode.unfocus(),
                  onChanged: (value) => bloc.add(Search(query: value)),
                ),
              ),
              body: IndexedStack(
                index: state.indexPageExplore,
                children: [
                  DiscoveryView(tabIndexDiscovery: indexPageDiscovery),
                  SearchView(query: state.query),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  reloadPage(BuildContext context) {
    final bloc = BlocProvider.of<ExploreBloc>(context);
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
  }

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}
