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
import 'package:tmdb/ui/pages/home/views/best_drama/bloc/best_drama_bloc.dart';
import 'package:tmdb/utils/utils.dart';

class BestDramaView extends StatelessWidget {
  const BestDramaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BestDramaBloc()
        ..add(FetchDataBestDrama(
          language: 'en-US',
          page: 1,
          withGenres: [18],
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Special dramas',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.bestDramaIcon.assetName,
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
                BlocProvider.of<BestDramaBloc>(context).add(FetchDataBestDrama(
                  language: 'en-US',
                  page: 1,
                  withGenres: [18],
                ));
              }
            },
            child: BlocConsumer<BestDramaBloc, BestDramaState>(
              listener: (context, state) {
                final homeBloc = BlocProvider.of<HomeBloc>(context);
                if (state is BestDramaAddWatchlistSuccess) {
                  showToast(
                      context,
                      (state.listState[state.index].watchlist ?? false)
                          ? '${state.listBestDrama[state.index].name} was added to Watchlist'
                          : '${state.listBestDrama[state.index].name} was removed from Watchlist');
                  BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                    notificationTypes: NotificationTypes.watchlist,
                  ));
                }
                if (state is BestDramaAddWatchlistError) {
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
                if (state is BestDramaAddFavoritesSuccess) {
                  showToast(
                      context,
                      (state.listState[state.index].favorite ?? false)
                          ? '${state.listBestDrama[state.index].name} was added to Favorites'
                          : '${state.listBestDrama[state.index].name} was removed from Favorites');
                  BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                    notificationTypes: NotificationTypes.favorites,
                  ));
                }
                if (state is BestDramaAddFavoritesError) {
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
                final bloc = BlocProvider.of<BestDramaBloc>(context);
                if (state is BestDramaInitial) {
                  return SizedBox(
                    height: 220.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is BestDramaError) {
                  return SizedBox(
                    height: 220.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return Stack(
                  children: [
                    const Positioned.fill(
                      child: PrimaryBackground(),
                    ),
                    SizedBox(
                      height: 220.h,
                      child: ListView.separated(
                        controller: bloc.scrollController,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: itemBuilder,
                        separatorBuilder: separatorBuilder,
                        itemCount:
                            state.listBestDrama.isNotEmpty ? state.listBestDrama.length + 1 : 21,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<BestDramaBloc>(context);
    final item = index < bloc.state.listBestDrama.length ? bloc.state.listBestDrama[index] : null;
    final itemState = index < bloc.state.listState.length ? bloc.state.listState[index] : null;
    return TertiaryItem(
      heroTag: '${AppConstants.bestDramaTvTag}-${item?.id}',
      index: index,
      itemCount: bloc.state.listBestDrama.length,
      title: item?.name,
      voteAverage: double.parse((item?.voteAverage ?? 0).toStringAsFixed(1)),
      imageUrl:
          item?.posterPath == null ? '' : '${AppConstants.kImagePathPoster}${item?.posterPath}',
      watchlist: itemState?.watchlist,
      favorite: itemState?.favorite,
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).pushNamed(
        AppMainRoutes.details,
        arguments: {
          'id': item?.id,
          'media_type': MediaType.tv,
          'hero_tag': '${AppConstants.bestDramaTvTag}-${item?.id}'
        },
      ),
      onTapBanner: bloc.state.listState.isNotEmpty
          ? () => (itemState?.watchlist ?? false)
              ? showCupertinoModalPopup(
                  context: context,
                  builder: (secondContext) => CustomBottomSheet(
                    title: '${item?.name} (${item?.firstAirDate?.substring(0, 4)})',
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
                    bloc.add(FetchDataBestDrama(
                      language: 'en-US',
                      page: 1,
                      withGenres: [18],
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
                    title: '${item?.name} (${item?.firstAirDate?.substring(0, 4)})',
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
                    bloc.add(FetchDataBestDrama(
                      language: 'en-US',
                      page: 1,
                      withGenres: [18],
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
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);

  addWatchlist(BuildContext context, int index) {
    final bloc = BlocProvider.of<BestDramaBloc>(context);
    bloc.add(AddWatchlist(
      mediaType: 'tv',
      mediaId: bloc.state.listBestDrama[index].id ?? 0,
      index: index,
    ));
  }

  removeWatchlist(BuildContext firstContext, BuildContext secondContext, int index) {
    addWatchlist(firstContext, index);
    Navigator.of(secondContext).pop();
  }

  addFavorites(BuildContext context, int index) {
    final bloc = BlocProvider.of<BestDramaBloc>(context);
    bloc.add(AddFavorites(
      mediaType: 'tv',
      mediaId: bloc.state.listBestDrama[index].id ?? 0,
      index: index,
    ));
  }

  removeFavorites(BuildContext firstContext, BuildContext secondContext, int index) {
    addFavorites(firstContext, index);
    Navigator.of(secondContext).pop();
  }

  showToast(BuildContext context, String statusMessage) {
    final bloc = BlocProvider.of<BestDramaBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => bloc.add(FetchDataBestDrama(
        language: 'en-US',
        page: 1,
        withGenres: [18],
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
