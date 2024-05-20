import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/favorite/views/movie/bloc/favorite_movie_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';

class FavoriteMovieView extends StatelessWidget {
  const FavoriteMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteMovieBloc()
        ..add(FetchData(
          language: 'en-US',
          sortBy: 'created_at.desc',
        )),
      child: BlocListener<TmdbBloc, TmdbState>(
        listener: (context, state) {
          if (state is TmdbWatchlistSuccess) {
            BlocProvider.of<FavoriteMovieBloc>(context).add(FetchData(
              language: 'en-US',
              sortBy: 'created_at.desc',
            ));
          }
        },
        child: BlocConsumer<FavoriteMovieBloc, FavoriteMovieState>(
          listener: (context, state) {
            final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
            if (state is FavoriteMovieSortSuccess) {
              bloc.add(LoadShimmer());
              bloc.add(FetchData(
                language: 'en-US',
                sortBy: state.sortBy,
              ));
            }
            if (state is FavoriteMovieAddWatchlistSuccess) {
              BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                notificationTypes: NotificationTypes.watchlist,
              ));
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
            return SmartRefresher(
              physics: const BouncingScrollPhysics(),
              controller: bloc.controller,
              enablePullDown: state.listFavorite.isNotEmpty,
              enablePullUp: state.listFavorite.isNotEmpty,
              primary: false,
              header: const Header(),
              footer: Footer(
                height: 70.h,
                noMoreStatus: 'All favorite movies was loaded !',
                failedStatus: 'Failed to load Movies !',
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
                  BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                    builder: (context, state) {
                      if (state is FavoriteMovieInitial) {
                        return const Expanded(
                          child: CustomIndicator(
                            radius: 15,
                          ),
                        );
                      }
                      if (state is FavoriteMovieError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.errorMessage),
                          ),
                        );
                      }
                      if (state is FavoriteMovieSuccess && state.listFavorite.isEmpty) {
                        return SecondaryRichText(
                          primaryText: 'Press',
                          secondaryText: 'to add to favorite movies',
                          icon: Icons.favorite,
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
                        itemCount: state.listFavorite.length,
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
    final state = BlocProvider.of<FavoriteMovieBloc>(context).state;
    final item = state.listFavorite[index];
    final itemState = state.listState[index];
    return QuaternaryItem(
      heroTag: '${AppConstants.favoriteMovieTag}-${item.id}',
      title: item.title ?? item.name,
      voteAverage: item.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: item.releaseDate!.isNotEmpty
          ? AppUtils().formatDate(item.releaseDate ?? '')
          : '00-00-0000',
      originalLanguage: item.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster92}/${item.posterPath}',
      watchlist: itemState.watchlist ?? false,
      rated: itemState.rated,
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
          'hero_tag': '${AppConstants.favoriteMovieTag}-${item.id}',
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
    final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
    status
        ? bloc.add(Sort(status: false, sortBy: sortBy))
        : bloc.add(Sort(status: true, sortBy: sortBy));
  }

  addWatchList(BuildContext context, int index) {
    final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
    bloc.add(AddWatchlist(
      mediaType: 'movie',
      mediaId: bloc.state.listFavorite[index].id ?? 0,
      index: index,
    ));
  }

  removeWatchList(BuildContext firstContext, BuildContext secondContext, int index) {
    addWatchList(firstContext, index);
    Navigator.of(secondContext).pop();
  }
}
