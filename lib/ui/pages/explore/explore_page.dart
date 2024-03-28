import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => SystemChannels.textInput.invokeMethod('TextInput.hide'),
    );
    super.initState();
  }

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
                      focusNode: bloc.focusNode,
                      controller: bloc.textController,
                      enabledSearch: enabledSearch,
                      isFocused: isFocused,
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
                        bloc.add(Clear());
                      },
                      onTapOutside: (event) {
                        setState(() {
                          isFocused = false;
                        });
                        bloc.focusNode.unfocus();
                      },
                      onChanged: (value) => bloc.add(Search(query: value)),
                    ),
                  ),
                  body: IndexedStack(
                    index: enabledSearch ? 0 : 1,
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
                  ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('Hello');
    BlocProvider.of<ExploreBloc>(context).focusNode.dispose();
    super.dispose();
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
