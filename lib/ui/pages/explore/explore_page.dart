import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/explore.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) => state is NavigationScrollSuccess ? reloadPage(context) : null,
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<ExploreBloc>(context);
            return Scaffold(
                backgroundColor: lightGreyColor.withOpacity(0.4),
                appBar: CustomAppBar(
                  customTitle: CustomTextField(
                    focusNode: bloc.focusNode,
                    controller: bloc.textController,
                    enabledSearch: state.enabledSearch,
                    hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                    suffixIcon: bloc.textController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              bloc.focusNode.requestFocus();
                              bloc.add(Clear());
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                              color: lightGreyColor,
                            ),
                          )
                        : null,
                    onTap: () => bloc.add(MoveToSearch(enabledSearch: true)),
                    onTapCancel: () {
                      bloc.add(MoveToSearch(enabledSearch: false));
                      bloc.textController.text.isNotEmpty ? bloc.add(Clear()) : null;
                    },
                    onTapOutside: (event) => bloc.focusNode.unfocus(),
                    onChanged: (value) => bloc.add(Search(query: value)),
                  ),
                ),
                body: IndexedStack(
                  index: state.enabledSearch ? 0 : 1,
                  children: [
                    SearchView(query: state.query),
                    const DiscoveryView(),
                  ],
                )
                // NotificationListener<ScrollNotification>(
                //   onNotification: (notification) {
                //     final scrollDirection = bloc.scrollController.position.userScrollDirection;
                //     if (scrollDirection == ScrollDirection.forward) {
                //       showNavigationBar(context);
                //       return false;
                //     } else if (scrollDirection == ScrollDirection.idle) {
                //       return false;
                //     } else {
                //       hideNavigationBar(context);
                //       return false;
                //     }
                //   },
                //   child: Stack(
                //     children: [
                //       SingleChildScrollView(
                //         physics: const BouncingScrollPhysics(),
                //         controller: bloc.scrollController,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             SizedBox(height: 20.h),
                //                const TrailerView(),
                //                SizedBox(height: 1000.h),
                //           ],
                //         ),
                //       ),
                //       CustomToast(
                //         statusMessage: state.statusMessage,
                //         opacity: state.opacity,
                //         visible: state.visible,
                //         onEndAnimation: () => state.opacity == 0.0
                //             ? bloc.add(DisplayToast(
                //                 visibility: false,
                //                 statusMessage: state.statusMessage,
                //               ))
                //             : null,
                //       ),
                //     ],
                //   ),
                // ),
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
