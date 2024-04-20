import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/watchlist/views/tv/bloc/watchlist_tv_bloc.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WatchlistTvView extends StatelessWidget {
  const WatchlistTvView({super.key});

  @override
  Widget build(BuildContext context) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    int accountId = 11429392;
    return BlocProvider(
      create: (context) => WatchlistTvBloc()
        ..add(FetchData(
          language: 'en-US',
          accountId: accountId,
          sessionId: sessionId,
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<WatchlistTvBloc, WatchlistTvState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<WatchlistTvBloc>(context);
          if (state is WatchlistTvSortSuccess) {
            bloc.add(LoadShimmer());
            bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            ));
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<WatchlistTvBloc>(context);
          return SmartRefresher(
            physics: const BouncingScrollPhysics(),
            controller: bloc.controller,
            enablePullDown: state.listWatchList.isNotEmpty,
            enablePullUp: state.listWatchList.isNotEmpty,
            primary: false,
            header: const Header(),
            footer: const Footer(
              height: 70,
              noMoreStatus: 'All watchlist tv shows was loaded !',
              failedStatus: 'Failed to load Tv Shows !',
            ),
            onRefresh: () => bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            )),
            onLoading: () => bloc.add(LoadMore(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SortButton(
                    icon: state.status ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    title: state.sortBy,
                    onTap: () => sortList(context, state.status, state.sortBy),
                  ),
                ),
                BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                  builder: (context, state) {
                    if (state is WatchlistTvInitial) {
                      return const Expanded(
                        child: CustomIndicator(
                          radius: 15,
                        ),
                      );
                    }
                    if (state is WatchlistTvError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.errorMessage),
                        ),
                      );
                    }
                    if (state is WatchlistTvSuccess && state.listWatchList.isEmpty) {
                      return SecondaryRichText(
                        primaryText: 'Press',
                        secondaryText: 'to add to watchlist tv shows',
                        icon: Icons.bookmark,
                        color: yellowColor,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      controller: ScrollController(),
                      padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0),
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listWatchList.length,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final itemWatchList = BlocProvider.of<WatchlistTvBloc>(context).state.listWatchList[index];
    return QuaternaryItem(
      title: itemWatchList.title ?? itemWatchList.name,
      voteAverage: itemWatchList.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: itemWatchList.firstAirDate!.isNotEmpty
          ? AppUtils().formatDate(itemWatchList.firstAirDate ?? '')
          : '00-00-0000',
      overview: itemWatchList.overview != '' ? itemWatchList.overview : 'Coming soon',
      originalLanguage: itemWatchList.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster}/${itemWatchList.posterPath}',
      onTapItem: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => Divider(
        height: 0,
        thickness: 1,
        color: gainsBoroColor,
      );

  sortList(BuildContext context, bool status, String sortBy) {
    final bloc = BlocProvider.of<WatchlistTvBloc>(context);
    status
        ? bloc.add(Sort(status: false, sortBy: sortBy))
        : bloc.add(Sort(status: true, sortBy: sortBy));
  }
}
