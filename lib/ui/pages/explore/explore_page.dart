import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/explore.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool enabledSearch = false;
  String b = 'Hello';
  bool isFocused = false;
  final Debouncer debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) => state is NavigationScrollSuccess ? reloadPage(context) : null,
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<ExploreBloc>(context);
            return ScaffoldMessenger(
              child: Scaffold(
                  appBar: CustomAppBar(
                    customTitle: CustomTextField(
                      controller: bloc.textController,
                      enabledSearch: enabledSearch,
                      isFocused: isFocused,
                      onTap: () {
                        setState(() {
                          enabledSearch = true;
                          isFocused = true;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          enabledSearch = false;
                          isFocused = false;
                        });
                        // print('Hello2$a');
                      },
                      onTapOutside: (event) {
                        setState(() {
                          isFocused = false;
                        });
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                      onChanged: (value) {
                        bloc.add(Search(query: value));
                      },
                      suffixIcon: bloc.textController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () => bloc.add(Clear()),
                              // () => fetchTrending(context),
                              icon: Icon(
                                Icons.cancel_rounded,
                                color: lightGreyColor,
                              ),
                            )
                          : null,
                      // onChanged: (value) {
                      //   bloc.add(LoadShimmer());
                      //   debouncer.call(() => fetchSearch(context, value));
                      // },
                    ),
                  ),
                  body: enabledSearch
                      ? SearchView(
                          query: state.query,
                        )
                      : DiscoveryView(
                          query: b,
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
                  // const TrailerView(),
                  // SizedBox(height: 1000.h),
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
