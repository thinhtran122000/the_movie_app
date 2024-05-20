import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/watchlist/views/tv/bloc/watchlist_tv_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';

class WatchlistTvView extends StatelessWidget {
  const WatchlistTvView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistTvBloc()
        ..add(FetchData(
          language: 'en-US',
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<WatchlistTvBloc, WatchlistTvState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<WatchlistTvBloc>(context);
          if (state is WatchlistTvSortSuccess) {
            bloc.add(LoadShimmer());
            bloc.add(FetchData(
              language: 'en-US',
              sortBy: state.sortBy,
            ));
          }
          if (state is WatchlistTvRemoveSuccess) {
            bloc.add(FetchData(
              language: 'en-US',
              sortBy: state.sortBy,
            ));
            BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
              notificationTypes: NotificationTypes.watchlist,
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
              sortBy: state.sortBy,
            )),
            onLoading: () => bloc.add(LoadMore(
              language: 'en-US',
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
    final bloc = BlocProvider.of<WatchlistTvBloc>(context);
    final item = bloc.state.listWatchList[index];
    final itemState = bloc.state.listTvState[index];
    return QuaternaryItem(
      heroTag: '${AppConstants.watchlistTvTag}-${item.id}',
      watchlist: itemState.watchlist,
      rated: itemState.rated,
      title: item.title ?? item.name,
      voteAverage: item.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: item.firstAirDate!.isNotEmpty
          ? AppUtils().formatDate(item.firstAirDate ?? '')
          : '00-00-0000',
      originalLanguage: item.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster92}/${item.posterPath}',
      onTapBanner: () => itemState.watchlist ?? true
          ? showCupertinoModalPopup(
              context: context,
              builder: (secondaryContext) => CustomBottomSheet(
                title:
                    '${item.name} (${(item.firstAirDate ?? '').isEmpty ? 'Unknown' : item.firstAirDate?.substring(0, 4)})',
                titleConfirm: 'Remove from Watchlist',
                titleCancel: 'Cancel',
                onPressCancel: () => Navigator.of(secondaryContext).pop(),
                onPressConfirm: () => removeWatchlist(context, secondaryContext, index),
              ),
            )
          : null,
      onTapItem: () => Navigator.of(context).pushNamed(
        AppMainRoutes.details,
        arguments: {
          'id': item.id,
          'media_type': MediaType.tv,
          'hero_tag': '${AppConstants.watchlistTvTag}-${item.id}',
        },
      ),
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

  removeWatchlist(BuildContext firstContext, BuildContext secondaryContext, int index) {
    final bloc = BlocProvider.of<WatchlistTvBloc>(firstContext);
    bloc.add(RemoveWatchlist(
      mediaType: 'tv',
      mediaId: bloc.state.listWatchList[index].id ?? 0,
      index: index,
    ));
    Navigator.of(secondaryContext).pop();
  }
}
