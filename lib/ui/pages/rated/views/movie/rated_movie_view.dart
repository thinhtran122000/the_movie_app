import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/rated/views/movie/bloc/rated_movie_bloc.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';

class RatedMovieView extends StatelessWidget {
  const RatedMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatedMovieBloc()
        ..add(FetchData(
          language: 'en-US',
          sortBy: 'created_at.desc',
        )),
      child: BlocListener<TmdbBloc, TmdbState>(
        listener: (context, state) {
          if (state is TmdbFavoritesSuccess ||
              state is TmdbWatchlistSuccess ||
              state is TmdbRatingSuccess ||
              state is TmdbLoginSuccess ||
              state is TmdbLogoutSuccess) {
            BlocProvider.of<RatedMovieBloc>(context).add(FetchData(
              language: 'en-US',
              sortBy: 'created_at.desc',
            ));
          }
        },
        child: BlocConsumer<RatedMovieBloc, RatedMovieState>(
          listener: (context, state) {
            final bloc = BlocProvider.of<RatedMovieBloc>(context);
            if (state is RatedMovieSortSuccess) {
              bloc.add(LoadShimmer());
              bloc.add(FetchData(
                language: 'en-US',
                sortBy: state.sortBy,
              ));
            }
            if (state is RatedMovieAddWatchlistSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    (state.listMovieState[state.index].watchlist ?? false)
                        ? '${state.listRated[state.index].title} was added to Watchlist'
                        : '${state.listRated[state.index].title} was removed from Watchlist',
                  ),
                ),
              );
              bloc.add(FetchData(
                language: 'en-US',
                sortBy: state.sortBy,
              ));
              BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                notificationTypes: NotificationTypes.watchlist,
              ));
            }
            //  if (state is FavoriteMovieAddWatchListSuccess) {
            //     BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange());
            //   }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<RatedMovieBloc>(context);
            return SmartRefresher(
              physics: const BouncingScrollPhysics(),
              controller: bloc.controller,
              enablePullDown: state.listRated.isNotEmpty,
              enablePullUp: state.listRated.isNotEmpty,
              primary: false,
              header: const Header(),
              footer: Footer(
                height: 70.h,
                noMoreStatus: 'All rated movies was loaded !',
                failedStatus: 'Failed to load movies !',
              ),
              onRefresh: () => bloc.add(FetchData(
                language: 'en-US',
                sortBy: state.sortBy,
              )),
              onLoading: () {
                bloc.add(LoadMore(
                  language: 'en-US',
                  sortBy: state.sortBy,
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SortButton(
                      title: state.sortBy,
                      icon: state.status ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      onTap: () => sortList(context, state.status, state.sortBy),
                    ),
                  ),
                  BlocBuilder<RatedMovieBloc, RatedMovieState>(
                    builder: (context, state) {
                      if (state is RatedMovieInitial) {
                        return const Expanded(
                          child: CustomIndicator(
                            radius: 15,
                          ),
                        );
                      }
                      if (state is RatedMovieError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.errorMessage),
                          ),
                        );
                      }
                      if (state is RatedMovieSuccess && state.listRated.isEmpty) {
                        return SecondaryRichText(
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
                        padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0),
                        itemBuilder: itemBuilder,
                        separatorBuilder: separatorBuilder,
                        itemCount: state.listRated.length,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<RatedMovieBloc>(context);
    final item = bloc.state.listRated[index];
    final itemState = bloc.state.listMovieState[index];
    return QuaternaryItem(
      heroTag: '${AppConstants.ratedMovieTag}-${item.id}',
      watchlist: itemState.watchlist,
      rated: itemState.rated,
      title: item.title ?? item.name,
      voteAverage: item.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: item.releaseDate!.isNotEmpty
          ? AppUtils().formatDate(item.releaseDate ?? '')
          : '00-00-0000',
      originalLanguage: item.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster92}/${item.posterPath}',
      onTapBanner: () => itemState.watchlist ?? false
          ? showCupertinoModalPopup(
              context: context,
              builder: (secondaryContext) => CustomBottomSheet(
                title:
                    '${item.title} (${(item.releaseDate ?? '').isEmpty ? 'Unknown' : item.releaseDate?.substring(0, 4)})',
                titleConfirm: 'Remove from Watchlist',
                titleCancel: 'Cancel',
                onPressCancel: () => Navigator.of(secondaryContext).pop(),
                onPressConfirm: () => removeWatchList(context, secondaryContext, index),
              ),
            )
          : addWatchList(context, index),
      onTapItem: () => Navigator.of(context).pushNamed(
        AppMainRoutes.details,
        arguments: {
          'id': item.id,
          'media_type': MediaType.movie,
          'hero_tag': '${AppConstants.ratedMovieTag}-${item.id}',
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
    final bloc = BlocProvider.of<RatedMovieBloc>(context);
    status
        ? bloc.add(Sort(status: false, sortBy: sortBy))
        : bloc.add(Sort(status: true, sortBy: sortBy));
  }

  addWatchList(BuildContext context, int index) {
    final bloc = BlocProvider.of<RatedMovieBloc>(context);
    bloc.add(AddWatchlist(
      mediaType: 'movie',
      mediaId: bloc.state.listRated[index].id ?? 0,
      index: index,
    ));
  }

  removeWatchList(BuildContext firstContext, BuildContext secondContext, int index) {
    addWatchList(firstContext, index);
    Navigator.of(secondContext).pop();
  }
}
