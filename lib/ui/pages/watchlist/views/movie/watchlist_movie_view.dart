import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/watchlist/views/movie/bloc/watchlist_movie_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WatchlistMovieView extends StatelessWidget {
  const WatchlistMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    int accountId = 11429392;
    return BlocProvider(
      create: (context) => WatchlistMovieBloc()
        ..add(FetchData(
          language: 'en-US',
          accountId: accountId,
          sessionId: sessionId,
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<WatchlistMovieBloc, WatchlistMovieState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<WatchlistMovieBloc>(context);
          if (state is WatchlistMovieSortSuccess) {
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
          final bloc = BlocProvider.of<WatchlistMovieBloc>(context);
          return SmartRefresher(
            physics: const BouncingScrollPhysics(),
            controller: bloc.controller,
            enablePullDown: state.listWatchList.isNotEmpty,
            enablePullUp: state.listWatchList.isNotEmpty,
            primary: false,
            header: const Header(),
            footer: const Footer(
              height: 70,
              noMoreStatus: 'All watchlist movies was loaded !',
              failedStatus: 'Failed to load Tv Shows !',
            ),
            onRefresh: () => bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            )),
            onLoading: () {
              bloc.add(LoadMore(
                language: 'en-US',
                accountId: accountId,
                sessionId: sessionId,
                sortBy: state.sortBy,
              ));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                CustomDropDown(
                  title: state.sortBy,
                  icon: state.status ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  onTap: () => sortList(context, state.status, state.sortBy),
                ),
                BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                  builder: (context, state) {
                    if (state is WatchlistMovieInitial) {
                      return const Expanded(
                        child: CustomIndicator(
                          radius: 15,
                        ),
                      );
                    }
                    if (state is WatchlistMovieError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.errorMessage),
                        ),
                      );
                    }
                    if (state is WatchlistMovieSuccess && state.listWatchList.isEmpty) {
                      return CustomTextRich(
                        primaryText: 'Press',
                        secondaryText: 'to add to watchlist movies',
                        icon: Icons.bookmark,
                        color: yellowColor,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      controller: ScrollController(),
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
    final itemWatchList = BlocProvider.of<WatchlistMovieBloc>(context).state.listWatchList[index];
    return QuaternaryItem(
      title: itemWatchList.title ?? itemWatchList.name,
      voteAverage: itemWatchList.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: itemWatchList.releaseDate!.isNotEmpty
          ? AppUtils().formatDate(itemWatchList.releaseDate ?? '')
          : '00-00-0000',
      overview: itemWatchList.overview != '' ? itemWatchList.overview : 'Coming soon',
      originalLanguage: itemWatchList.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster}/${itemWatchList.posterPath}',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);

  sortList(BuildContext context, bool status, String sortBy) {
    final bloc = BlocProvider.of<WatchlistMovieBloc>(context);
    status
        ? bloc.add(Sort(status: false, sortBy: sortBy))
        : bloc.add(Sort(status: true, sortBy: sortBy));
  }
}
