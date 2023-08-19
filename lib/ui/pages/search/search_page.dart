import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/filter/filter_page.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/ui/pages/search/bloc/search_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer();
    return BlocProvider(
      create: (context) => SearchBloc()
        ..add(FetchData(
          query: '',
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
          includeAdult: true,
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is NavigationInitial) {
            fetchTrending(context);
            BlocProvider.of<SearchBloc>(context).add(ScrollToTop());
          }
        },
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            final bloc = BlocProvider.of<SearchBloc>(context);
            return Scaffold(
              backgroundColor: darkWhiteColor,
              appBar: CustomAppBar(
                leadingWidth: 0,
                centerTitle: false,
                title: const CustomAppBarTitle(
                  titleAppBar: 'Search',
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                    child: Image.asset(
                      ImagesPath.primaryShortLogo.assetName,
                      scale: 4,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
              body: NotificationListener<UserScrollNotification>(
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
                  return true;
                },
                child: Stack(
                  children: [
                    BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchInitial) {
                          return const CustomIndicator(
                            radius: 20,
                          );
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 88),
                            Expanded(
                              child: Stack(
                                children: [
                                  BlocBuilder<SearchBloc, SearchState>(
                                    builder: (context, state) {
                                      if (state is SearchError) {
                                        return Center(
                                          child: Text(state.errorMessage),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                  NotificationListener<ScrollNotification>(
                                    onNotification: state.visible
                                        ? (notification) {
                                            if (bloc.scrollController.hasClients &&
                                                bloc.scrollController.offset <= 2000) {
                                              hideButton(context);
                                              return true;
                                            }
                                            return false;
                                          }
                                        : (notification) {
                                            if (bloc.scrollController.hasClients &&
                                                bloc.scrollController.offset > 2000) {
                                              showButton(context);
                                              return true;
                                            }
                                            return false;
                                          },
                                    child: SmartRefresher(
                                      scrollController: bloc.scrollController,
                                      controller: bloc.refreshController,
                                      enablePullUp:
                                          enablePullUp(state.listSearch, state.listTrending),
                                      enablePullDown:
                                          enablePullUp(state.listSearch, state.listTrending),
                                      header: const Header(),
                                      footer: const Footer(
                                        height: 140,
                                        noMoreStatus: 'All results was loaded !',
                                        failedStatus: 'Failed to load results !',
                                      ),
                                      onRefresh: () => fetchSearch(context, state.query),
                                      onLoading: () => loadMore(context, state.query),
                                      child: MasonryGridView.count(
                                        addAutomaticKeepAlives: false,
                                        addRepaintBoundaries: false,
                                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        shrinkWrap: true,
                                        itemBuilder: itemBuilder,
                                        itemCount: state.listSearch.isNotEmpty
                                            ? state.listSearch.length
                                            : state.listTrending.length,
                                      ),
                                    ),
                                  ),
                                  CustomScrollButton(
                                    visible: state.visible,
                                    opacity: state.visible ? 1.0 : 0.0,
                                    onTap: state.visible ? () => scrollToTop(context) : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      color: darkWhiteColor,
                      child: CustomTextField(
                        controller: bloc.textController,
                        hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                        onTapFilter: () => goToFilterPage(context),
                        suffixIcon: bloc.textController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () => fetchTrending(context),
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: lightGreyColor,
                                ),
                              )
                            : null,
                        onChanged: (value) => debouncer.call(() => fetchSearch(context, value)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<SearchBloc>(context).state;
    final item = state.listSearch.isNotEmpty ? state.listSearch[index] : state.listTrending[index];
    return GridItem(
      title: item.title ?? item.name,
      releaseYear: AppUtils().getYearReleaseOrDepartment(
        item.releaseDate,
        item.firstAirDate,
        item.mediaType ?? '',
        item.knownForDepartment,
      ),
      imageUrl: AppUtils().getImageUrl(item.posterPath, item.profilePath),
    );
  }

  bool enablePullUp(List<MultipleMedia> listSearch, List<MultipleMedia> listTrending) {
    if (listSearch.isEmpty && listTrending.isEmpty) {
      return false;
    } else {
      if (listSearch.isEmpty && listTrending.isNotEmpty) {
        return true;
      } else if (listSearch.isNotEmpty && listTrending.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

  fetchSearch(BuildContext context, String query) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(ScrollToTop());
    bloc.add(FetchData(
      query: query,
      includeAdult: true,
      language: 'en-US',
      mediaType: 'all',
      timeWindow: 'day',
    ));
  }

  loadMore(BuildContext context, String query) => BlocProvider.of<SearchBloc>(context).add(
        LoadMore(
          query: query,
          includeAdult: true,
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
        ),
      );

  fetchTrending(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).textController.clear();
    fetchSearch(context, '');
  }

  bool showButton(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(ShowHideButton(visible: true));
    return true;
  }

  bool hideButton(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(ShowHideButton(visible: false));
    return true;
  }

  scrollToTop(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    showIndicator(context);
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        Navigator.of(context).pop();
        fetchSearch(context, bloc.state.query);
        navigationBloc.add(ShowHide(visible: true));
      },
    );
  }

  goToFilterPage(BuildContext context) {
    showNavigationBar(context);
    fetchTrending(context);
    Navigator.of(context).push(
      CustomPageRoute(
        page: const FilterPage(),
        begin: const Offset(1, 0),
      ),
    );
  }

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
