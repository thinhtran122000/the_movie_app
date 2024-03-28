import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/search/views/recent/bloc/recent_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/ui/ui.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecentView extends StatelessWidget {
  const RecentView({super.key});

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer();
    return BlocProvider(
      create: (context) => RecentBloc()
        ..add(FetchData(
          query: '',
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
          includeAdult: true,
        )),
      child: BlocListener<ExploreBloc, ExploreState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<RecentBloc>(context);
          if (state is ExploreSuccess) {
            bloc.add(LoadShimmer());
            debouncer.call(() => fetchSearch(context, state.query));
          }
          if (state is ExploreClearSuccess) {
            bloc.add(LoadShimmer());
            debouncer.call(() => fetchSearch(context, state.query));
          }
        },
        child: BlocBuilder<RecentBloc, RecentState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<RecentBloc>(context);
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
              child: NotificationListener<ScrollNotification>(
                onNotification: state.visible
                    ? (notification) {
                        if (bloc.scrollController.hasClients &&
                            bloc.scrollController.offset <= 2000) {
                          hideButton(context);
                          return false;
                        }
                        return false;
                      }
                    : (notification) {
                        if (bloc.scrollController.hasClients &&
                            bloc.scrollController.offset > 2000) {
                          showButton(context);
                          return false;
                        }
                        return false;
                      },
                child: BlocBuilder<RecentBloc, RecentState>(
                  builder: (context, state) {
                    if (state is RecentInitial) {
                      return const Center(
                        child: CustomIndicator(
                          radius: 10,
                        ),
                      );
                    }
                    if (state is RecentError) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    }
                    return ScrollConfiguration(
                      behavior: const CupertinoScrollBehavior(),
                      child: Stack(
                        children: [
                          SmartRefresher(
                            scrollController: bloc.scrollController,
                            controller: bloc.refreshController,
                            enablePullUp:
                                enablePullUp(state.listSearch, state.listTrending, context),
                            enablePullDown:
                                enablePullUp(state.listSearch, state.listTrending, context),
                            header: const Header(),
                            footer: Footer(
                              height: 140.h,
                              noMoreStatus: 'All results was loaded !',
                              failedStatus: 'Failed to load results !',
                            ),
                            onRefresh: () => fetchSearch(
                              context,
                              BlocProvider.of<RecentBloc>(context).state.query,
                            ),
                            onLoading: () => loadMore(
                              context,
                              BlocProvider.of<RecentBloc>(context).state.query,
                            ),
                            child: MasonryGridView.count(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0),
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.h,
                              mainAxisSpacing: 16.w,
                              shrinkWrap: true,
                              itemBuilder: itemBuilder,
                              itemCount: state.listSearch.isNotEmpty
                                  ? state.listSearch.length
                                  : state.listTrending.length,
                            ),
                          ),
                          CustomScrollButton(
                            visible: state.visible,
                            onTap: state.visible ? () => reloadPage(context) : null,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Container(
  //   color: darkWhiteColor,
  //   child: CustomTextField(
  //     controller: bloc.textController,
  //     hintText: 'Search for movies, tv shows, people...'.padLeft(14),
  //     suffixIcon: bloc.textController.text.isNotEmpty
  //         ? IconButton(
  //             onPressed: () => fetchTrending(context),
  //             icon: Icon(
  //               Icons.cancel_rounded,
  //               color: lightGreyColor,
  //             ),
  //           )
  //         : null,
  //     onChanged: (value) {
  //       bloc.add(LoadShimmer());
  //       debouncer.call(() => fetchSearch(context, value));
  //     },
  //   ),
  // ),

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<RecentBloc>(context).state;
    final item = state.listSearch.isNotEmpty ? state.listSearch[index] : state.listTrending[index];
    return GridItem(
      index: index,
      title: item.title ?? item.name,
      releaseYear: '(${AppUtils().getYearReleaseOrDepartment(
        item.releaseDate,
        item.firstAirDate,
        item.mediaType ?? '',
        item.knownForDepartment,
      )})',
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: DetailsPage(
            title: item.title ?? item.name,
          ),
          begin: const Offset(1, 0),
        ),
      ),
      imageUrl: item.posterPath != null
          ? '${AppConstants.kImagePathPoster}${item.posterPath}'
          : (item.profilePath != null
              ? '${AppConstants.kImagePathPoster}${item.profilePath}'
              : 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'),
    );
  }

  bool enablePullUp(
      List<MultipleMedia> listSearch, List<MultipleMedia> listTrending, BuildContext context) {
    final state = BlocProvider.of<RecentBloc>(context).state;
    if (state is RecentError) {
      return false;
    } else if (state is RecentSuccess) {
      return true;
    } else {
      return false;
    }
  }

  fetchSearch(BuildContext context, String query) =>
      BlocProvider.of<RecentBloc>(context).add(FetchData(
        query: query,
        includeAdult: true,
        language: 'en-US',
        mediaType: 'all',
        timeWindow: 'day',
      ));

  loadMore(BuildContext context, String query) => BlocProvider.of<RecentBloc>(context).add(
        LoadMore(
          query: query,
          includeAdult: true,
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
        ),
      );

  fetchTrending(BuildContext context, String query) {
    final bloc = BlocProvider.of<RecentBloc>(context);
    // bloc.textController.clear();
    fetchSearch(
      context, query,
      // bloc.textController.text
    );
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.jumpTo(0);
    }
  }

  bool showButton(BuildContext context) {
    BlocProvider.of<RecentBloc>(context).add(ShowHideButton(visible: true));
    return true;
  }

  bool hideButton(BuildContext context) {
    BlocProvider.of<RecentBloc>(context).add(ShowHideButton(visible: false));
    return true;
  }

  reloadPage(BuildContext context) {
    final bloc = BlocProvider.of<RecentBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    bloc.state.query.isNotEmpty ? fetchSearch(context, bloc.state.query) : fetchSearch(context, '');
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.animateTo(
        bloc.scrollController.position.minScrollExtent,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500),
      );
    }
    navigationBloc.add(ShowHide(visible: true));
  }

  // goToFilterPage(BuildContext context) {
  //   showNavigationBar(context);
  //   fetchTrending(context);
  //   Navigator.of(context).push(
  //     CustomPageRoute(
  //       page: const FilterPage(),
  //       begin: const Offset(1, 0),
  //     ),
  //   );
  // }

  showIndicator(BuildContext context) => AppUtils().showCustomDialog(
        context: context,
        alignment: const Alignment(0, 0.2),
        child: const CustomIndicator(
          radius: 15,
        ),
      );

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}
