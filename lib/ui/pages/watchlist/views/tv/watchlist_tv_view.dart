import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/watchlist/views/tv/bloc/watchlist_tv_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';
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
                const SizedBox(height: 5),
                CustomDropDown(
                  icon: state.status ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  title: state.sortBy,
                  onTap: () => sortList(context, state.status, state.sortBy),
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
                      return CustomTextRich(
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
                      controller: ScrollController(keepScrollOffset: false),
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
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
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);

  sortList(BuildContext context, bool status, String sortBy) {
    final bloc = BlocProvider.of<WatchlistTvBloc>(context);
    status
        ? bloc.add(Sort(status: false, sortBy: sortBy))
        : bloc.add(Sort(status: true, sortBy: sortBy));
  }
}
