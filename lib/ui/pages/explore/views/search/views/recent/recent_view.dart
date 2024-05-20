import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:tmdb/ui/pages/explore/views/search/views/recent/bloc/recent_bloc.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/debouncer/debouncer.dart';
import 'package:tmdb/utils/utils.dart';

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
          isSearching: false,
        )),
      child: BlocListener<ExploreBloc, ExploreState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<RecentBloc>(context);

          if (state is ExploreSearchSuccess) {
            debouncer.call(() => fetchSearch(context, state.query, true));
          }
          if (state is ExploreSuccess) {
            debouncer.call(() => fetchSearch(context, state.query, false));
            if (bloc.scrollController.hasClients) {
              bloc.scrollController.jumpTo(
                bloc.scrollController.position.minScrollExtent,
              );
            }
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
              child: BlocBuilder<RecentBloc, RecentState>(
                builder: (context, state) {
                  final bloc = BlocProvider.of<RecentBloc>(context);
                  if (state is RecentInitial) {
                    return const Center(
                      child: CustomIndicator(
                        radius: 10,
                      ),
                    );
                  }
                  if (state is RecentLoading) {
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
                    child: SmartRefresher(
                      scrollController: bloc.scrollController,
                      controller: bloc.refreshController,
                      enablePullUp: enablePull(
                        state.listSearch,
                        state.listTrending,
                        context,
                      ),
                      enablePullDown: enablePull(
                        state.listSearch,
                        state.listTrending,
                        context,
                      ),
                      header: const Header(),
                      footer: Footer(
                        height: 140.h,
                        noMoreStatus: 'All results was loaded !',
                        failedStatus: 'Failed to load results !',
                      ),
                      onRefresh: () => fetchSearch(
                        context,
                        bloc.state.query,
                        false,
                      ),
                      onLoading: () => loadMore(
                        context,
                        bloc.state.query,
                      ),
                      child: MasonryGridView.count(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.h,
                        mainAxisSpacing: 16.w,
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(
                          13.w,
                          state.query.isEmpty ? 50.h : 20.h,
                          13.w,
                          0,
                        ),
                        itemBuilder: itemBuilder,
                        itemCount: state.listSearch.isNotEmpty
                            ? state.listSearch.length
                            : state.listTrending.length,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<RecentBloc>(context).state;
    final item = state.listSearch.isNotEmpty ? state.listSearch[index] : state.listTrending[index];
    return GridItem(
      heroTag: '${AppConstants.recentSearchTag}-${item.id}',
      index: index,
      title: item.title ?? item.name,
      releaseYear: '(${AppUtils().getYearReleaseOrDepartment(
        item.releaseDate,
        item.firstAirDate,
        item.lastAirDate,
        item.mediaType ?? '',
        item.knownForDepartment,
      )})',
      imageUrl: item.posterPath != null
          ? '${AppConstants.kImagePathPoster}${item.posterPath}'
          : (item.profilePath != null
              ? '${AppConstants.kImagePathPoster}${item.profilePath}'
              : 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'),
      onTapItem: () => Navigator.of(context).pushNamed(
        AppMainRoutes.details,
        arguments: {
          'id': item.id,
          'media_type': AppUtils().getMediaType(item.mediaType),
          'hero_tag': '${AppConstants.recentSearchTag}-${item.id}',
        },
      ),
    );
  }

  bool enablePull(
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

  fetchSearch(BuildContext context, String query, bool isSearching) =>
      BlocProvider.of<RecentBloc>(context).add(FetchData(
        isSearching: isSearching,
        query: query,
        includeAdult: true,
        language: 'en-US',
        mediaType: 'all',
        timeWindow: 'day',
      ));

  loadMore(BuildContext context, String query) => Debouncer().call(() {
        BlocProvider.of<RecentBloc>(context).add(
          LoadMore(
            query: query,
            includeAdult: true,
            language: 'en-US',
            mediaType: 'all',
            timeWindow: 'day',
          ),
        );
      });

  fetchTrending(BuildContext context, String query) {
    final bloc = BlocProvider.of<RecentBloc>(context);
    fetchSearch(context, query, false);
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.jumpTo(0);
    }
  }

  reloadPage(BuildContext context) {
    final bloc = BlocProvider.of<RecentBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    bloc.state.query.isNotEmpty
        ? fetchSearch(context, bloc.state.query, false)
        : fetchSearch(context, '', false);
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.animateTo(
        bloc.scrollController.position.minScrollExtent,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500),
      );
    }
    navigationBloc.add(ShowHide(visible: true));
  }

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}
