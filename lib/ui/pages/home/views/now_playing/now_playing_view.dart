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
import 'package:tmdb/ui/pages/home/views/now_playing/bloc/now_playing_bloc.dart';
import 'package:tmdb/utils/utils.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingBloc()
        ..add(FetchDataNowPlaying(
          language: 'en-US',
          page: 1,
          fetchFeature: true,
        )),
      child: BlocListener<TmdbBloc, TmdbState>(
        listener: (context, state) {
          if (state is TmdbFavoritesSuccess ||
              state is TmdbWatchlistSuccess ||
              state is TmdbRatingSuccess ||
              state is TmdbLoginSuccess ||
              state is TmdbLogoutSuccess) {
            BlocProvider.of<NowPlayingBloc>(context).add(FetchDataNowPlaying(
              language: 'en-US',
              page: 1,
              fetchFeature: false,
            ));
          }
        },
        child: BlocConsumer<NowPlayingBloc, NowPlayingState>(
          listener: (context, state) {
            if (state is NowPlayingAddFavoritesSuccess) {
              showToast(
                  context,
                  (state.mediaState?.favorite ?? false)
                      ? '${state.nowPlayingTv.name} was added to Favorites'
                      : '${state.nowPlayingTv.name} was removed from Favorites');
              BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                notificationTypes: NotificationTypes.favorites,
              ));
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<NowPlayingBloc>(context);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryText(
                  title: 'On streaming now',
                  visibleIcon: true,
                  onTapViewAll: () => bloc.add(FetchDataNowPlaying(
                    language: 'en-US',
                    page: 1,
                    fetchFeature: true,
                  )),
                  icon: SvgPicture.asset(
                    IconsPath.nowPlayingIcon.assetName,
                  ),
                ),
                SizedBox(height: 15.h),
                BlocBuilder<NowPlayingBloc, NowPlayingState>(
                  builder: (context, state) {
                    if (state is NowPlayingInitial) {
                      return SizedBox(
                        height: 172.h,
                        child: const CustomIndicator(),
                      );
                    }
                    if (state is NowPlayingError) {
                      return SizedBox(
                        height: 172.h,
                        child: Center(
                          child: Text(state.runtimeType.toString()),
                        ),
                      );
                    }
                    final item = state.nowPlayingTv;
                    return SingleItem(
                      heroTag: AppConstants.nowPlayingTvTag,
                      title: item.name,
                      season: item.lastEpisodeToAir?.seasonNumber,
                      episode: item.lastEpisodeToAir?.episodeNumber,
                      overview: item.overview != '' ? item.overview : 'No description available',
                      averageLuminance: state.averageLuminance,
                      posterPath: item.posterPath,
                      imageUrl: '${AppConstants.kImagePathPoster}${item.posterPath}',
                      colors: state.paletteColors,
                      stops:
                          state.paletteColors.asMap().keys.toList().map((e) => e * 0.13).toList(),
                      favorite: state.mediaState?.favorite,
                      onTapFavor: state.mediaState != null
                          ? () => (state.mediaState?.favorite ?? false)
                              ? showCupertinoModalPopup(
                                  context: context,
                                  builder: (secondContext) => CustomBottomSheet(
                                    title: '${item.name} (${item.firstAirDate?.substring(0, 4)})',
                                    titleConfirm: 'Remove from Favorites',
                                    titleCancel: 'Cancel',
                                    onPressCancel: () => Navigator.of(secondContext).pop(),
                                    onPressConfirm: () => removeFavorites(context, secondContext),
                                  ),
                                )
                              : addFavorites(context)
                          : () => Navigator.of(context).pushNamed(
                                AppMainRoutes.authentication,
                                arguments: {
                                  'is_later_login': true,
                                },
                              ).then(
                                (results) async {
                                  if ((results as bool?) != null && results == true) {
                                    bloc.add(FetchDataNowPlaying(
                                      language: 'en-US',
                                      page: 1,
                                      fetchFeature: false,
                                    ));
                                    await Future.delayed(
                                      const Duration(seconds: 3),
                                      () => addFavorites(context),
                                    );
                                  } else {
                                    return;
                                  }
                                },
                              ),
                      onTapItem: () => Navigator.of(context).pushNamed(
                        AppMainRoutes.details,
                        arguments: {
                          'id': item.id,
                          'media_type': MediaType.tv,
                          'hero_tag': AppConstants.nowPlayingTvTag
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  addFavorites(BuildContext context) {
    final bloc = BlocProvider.of<NowPlayingBloc>(context);
    bloc.add(AddFavorites(
      mediaType: 'tv',
      mediaId: bloc.state.nowPlayingTv.id ?? 0,
    ));
  }

  removeFavorites(BuildContext firstContext, BuildContext secondContext) {
    addFavorites(firstContext);
    Navigator.of(secondContext).pop();
  }

  showToast(BuildContext context, String statusMessage) {
    final bloc = BlocProvider.of<NowPlayingBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => bloc.add(FetchDataNowPlaying(
        page: 1,
        language: 'en-US',
        fetchFeature: false,
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
