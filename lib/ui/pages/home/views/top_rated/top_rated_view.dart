import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/home/bloc/home_bloc.dart';
import 'package:tmdb/ui/pages/home/views/top_rated/bloc/top_rated_bloc.dart';
import 'package:tmdb/utils/utils.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopRatedBloc()
        ..add(FetchDataTopRated(
          page: 1,
          language: 'en-US',
          region: '',
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Top 10 rated movies',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.topRatedIcon.assetName,
            ),
          ),
          SizedBox(height: 15.h),
          BlocListener<TmdbBloc, TmdbState>(
            listener: (context, state) {
              if (state is TmdbWatchlistSuccess ||
                  state is TmdbFavoritesSuccess ||
                  state is TmdbRatingSuccess ||
                  state is TmdbLoginSuccess ||
                  state is TmdbLogoutSuccess) {
                BlocProvider.of<TopRatedBloc>(context).add(FetchDataTopRated(
                  page: 1,
                  language: 'en-US',
                  region: '',
                ));
              }
            },
            child: BlocConsumer<TopRatedBloc, TopRatedState>(
              listener: (context, state) {
                final homeBloc = BlocProvider.of<HomeBloc>(context);
                if (state is TopRatedAddWatchlistSuccess) {
                  showToast(
                      context,
                      (state.listState[state.index].watchlist ?? false)
                          ? '${state.listTopRated[state.index].title} was added to Watchlist'
                          : '${state.listTopRated[state.index].title} was removed from Watchlist');
                  BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                    notificationTypes: NotificationTypes.watchlist,
                  ));
                }
                if (state is TopRatedAddWatchlistError) {
                  homeBloc.add(DisplayToast(
                    visible: true,
                    statusMessage: state.errorMessage,
                  ));
                  homeBloc.add(ChangeAnimationToast(opacity: 1.0));
                  Timer(
                    const Duration(seconds: 2),
                    () => homeBloc.add(ChangeAnimationToast(opacity: 0.0)),
                  );
                }
                if (state is TopRatedAddFavoritesSuccess) {
                  showToast(
                      context,
                      (state.listState[state.index].favorite ?? false)
                          ? '${state.listTopRated[state.index].title} was added to Favorites'
                          : '${state.listTopRated[state.index].title} was removed from Favorites');
                  BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                    notificationTypes: NotificationTypes.favorites,
                  ));
                }
                if (state is TopRatedAddFavoritesError) {
                  homeBloc.add(DisplayToast(
                    visible: true,
                    statusMessage: state.errorMessage,
                  ));
                  homeBloc.add(ChangeAnimationToast(opacity: 1.0));
                  Timer(
                    const Duration(seconds: 2),
                    () => homeBloc.add(ChangeAnimationToast(opacity: 0.0)),
                  );
                }
              },
              builder: (context, state) {
                if (state is TopRatedInitial) {
                  return SizedBox(
                    height: 240.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is TopRatedError) {
                  return SizedBox(
                    height: 240.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return SizedBox(
                  height: 240.h,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilder,
                    separatorBuilder: separatorBuilder,
                    itemCount: (state.listTopRated.length / 2).round(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final item = bloc.state.listTopRated[index];
    final itemState = bloc.state.listState.isNotEmpty ? bloc.state.listState[index] : null;
    
    return SenaryItem(
      heroTag: '${AppConstants.topratedMovieTag}-${item.id}',
      title: item.title ?? '',
      rank: '${index + 1}',
      voteAverage: double.parse((item.voteAverage ?? 0).toStringAsFixed(1)),
      imageUrl: item.posterPath == null ? '' : '${AppConstants.kImagePathPoster}${item.posterPath}',
      watchlist: itemState?.watchlist,
      favorite: itemState?.favorite,
      onTapBanner: bloc.state.listState.isNotEmpty
          ? () => (itemState?.watchlist ?? false)
              ? showCupertinoModalPopup(
                  context: context,
                  builder: (secondContext) => CustomBottomSheet(
                    title: '${item.title} (${item.releaseDate?.substring(0, 4)})',
                    titleConfirm: 'Remove from Watchlist',
                    titleCancel: 'Cancel',
                    onPressCancel: () => Navigator.of(secondContext).pop(),
                    onPressConfirm: () => removeWatchlist(context, secondContext, index),
                  ),
                )
              : addWatchlist(context, index)
          : () => Navigator.of(context).pushNamed(
                AppMainRoutes.authentication,
                arguments: {
                  'is_later_login': true,
                },
              ).then(
                (results) async {
                  if ((results as bool?) != null && results == true) {
                    bloc.add(FetchDataTopRated(
                      page: 1,
                      language: 'en-US',
                      region: '',
                    ));
                    await Future.delayed(
                      const Duration(seconds: 3),
                      () => addWatchlist(context, index),
                    );
                  } else {
                    return;
                  }
                },
              ),
      onTapFavor: bloc.state.listState.isNotEmpty
          ? () => (itemState?.favorite ?? false)
              ? showCupertinoModalPopup(
                  context: context,
                  builder: (secondContext) => CustomBottomSheet(
                    title: '${item.title} (${item.releaseDate?.substring(0, 4)})',
                    titleConfirm: 'Remove from Favorites',
                    titleCancel: 'Cancel',
                    onPressCancel: () => Navigator.of(secondContext).pop(),
                    onPressConfirm: () => removeFavorites(context, secondContext, index),
                  ),
                )
              : addFavorites(context, index)
          : () => Navigator.of(context).pushNamed(
                AppMainRoutes.authentication,
                arguments: {
                  'is_later_login': true,
                },
              ).then(
                (results) async {
                  if ((results as bool?) != null && results == true) {
                    bloc.add(FetchDataTopRated(
                      page: 1,
                      language: 'en-US',
                      region: '',
                    ));
                    await Future.delayed(
                      const Duration(seconds: 3),
                      () => addFavorites(context, index),
                    );
                  } else {
                    return;
                  }
                },
              ),
      onTapItem: () {
        BlocProvider.of<HomeBloc>(context).add(DisableTrailer());
        Navigator.of(context).pushNamed(
          AppMainRoutes.details,
          arguments: {
            'id': item.id,
            'media_type': MediaType.movie,
            'hero_tag': '${AppConstants.topratedMovieTag}-${item.id}',
          },
        );
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);

  addWatchlist(BuildContext context, int index) {
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    bloc.add(AddWatchlist(
      mediaType: 'movie',
      mediaId: bloc.state.listTopRated[index].id ?? 0,
      index: index,
    ));
  }

  removeWatchlist(BuildContext firstContext, BuildContext secondContext, int index) {
    addWatchlist(firstContext, index);
    Navigator.of(secondContext).pop();
  }

  addFavorites(BuildContext context, int index) {
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    bloc.add(AddFavorites(
      mediaType: 'movie',
      mediaId: bloc.state.listTopRated[index].id ?? 0,
      index: index,
    ));
  }

  removeFavorites(BuildContext firstContext, BuildContext secondContext, int index) {
    addFavorites(firstContext, index);
    Navigator.of(secondContext).pop();
  }

  showToast(BuildContext context, String statusMessage) {
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => bloc.add(FetchDataTopRated(
        page: 1,
        language: 'en-US',
        region: '',
      )),
    )
        .then(
          (_) => homeBloc.add(DisplayToast(
            visible: true,
            statusMessage: statusMessage,
          )),
        )
        .then(
          (_) => homeBloc.add(ChangeAnimationToast(opacity: 1.0)),
        );
    Timer(
      const Duration(seconds: 2),
      () => homeBloc.add(ChangeAnimationToast(opacity: 0.0)),
    );
  }
}
