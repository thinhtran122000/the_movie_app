import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/details/bloc/details_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';

class DetailsPage extends StatelessWidget {
  final MediaType? mediaType;
  final String? heroTag;
  final String? title;
  final int? id;
  final bool? isBackdrop;
  const DetailsPage({
    super.key,
    this.heroTag,
    this.title,
    this.id,
    this.mediaType,
    this.isBackdrop,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => DetailsBloc()
        ..add(FetchDataDetails(
          id: id ?? 0,
          mediaType: mediaType ?? MediaType.movie,
          language: 'en-US',
        )),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TmdbBloc, TmdbState>(
            listener: (context, state) {
              if (state is TmdbFavoritesSuccess ||
                  state is TmdbWatchlistSuccess ||
                  state is TmdbRatingSuccess ||
                  state is TmdbLoginSuccess ||
                  state is TmdbLogoutSuccess) {
                BlocProvider.of<DetailsBloc>(context).add(FetchState(
                  id: id ?? 0,
                  mediaType: mediaType ?? MediaType.movie,
                ));
              }
            },
          ),
          BlocListener<DetailsBloc, DetailsState>(
            listener: (context, state) {
              if (state is DetailsAddFavoriteSuccess) {
                BlocProvider.of<DetailsBloc>(context).add(FetchState(
                  id: id ?? 0,
                  mediaType: mediaType ?? MediaType.movie,
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      (state.mediaState?.favorite ?? false)
                          ? '${state.multipleDetails.title ?? state.multipleDetails.name} was added to Favorites'
                          : '${state.multipleDetails.title ?? state.multipleDetails.name} was removed from Favorites',
                    ),
                  ),
                );
                BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                  notificationTypes: NotificationTypes.favorites,
                ));
              }
              if (state is DetailsAddWatchlistSuccess) {
                BlocProvider.of<DetailsBloc>(context).add(FetchState(
                  id: id ?? 0,
                  mediaType: mediaType ?? MediaType.movie,
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      (state.mediaState?.watchlist ?? false)
                          ? '${state.multipleDetails.title ?? state.multipleDetails.name} was added to Watchlist'
                          : '${state.multipleDetails.title ?? state.multipleDetails.name} was removed from Watchlist',
                    ),
                  ),
                );
                BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                  notificationTypes: NotificationTypes.watchlist,
                ));
              }
            },
          ),
        ],
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: gainsBoroColor,
              appBar: CustomAppBar(
                centerTitle: true,
                title: state.multipleDetails.title ?? state.multipleDetails.name,
                titleStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: whiteColor,
                ),
                leading: Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                  size: 20.sp,
                ),
                onTapLeading: () => Navigator.of(context).pop(),
                actions: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      IconsPath.optionIcon.assetName,
                      width: 2.w,
                      height: 4.h,
                      colorFilter: ColorFilter.mode(
                        whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              body: BlocBuilder<DetailsBloc, DetailsState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: whiteSmokeColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15.w, 15.h, 10.w, 15.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            mediaType == MediaType.movie
                                                ? '${state.multipleDetails.title}'
                                                : '${state.multipleDetails.name}',
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            textScaler: const TextScaler.linear(1),
                                            style: TextStyle(
                                              color: blackColor,
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.normal,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: noColor,
                                          child: InkWell(
                                            customBorder: const CircleBorder(),
                                            onTap: state.mediaState == null
                                                ? () => Navigator.of(context).pushNamed(
                                                      AppMainRoutes.authentication,
                                                      arguments: {
                                                        'is_later_login': true,
                                                      },
                                                    ).then(
                                                      (results) async {
                                                        if ((results as bool?) != null &&
                                                            results == true) {
                                                          await Future.delayed(
                                                            const Duration(seconds: 2),
                                                            () => addFavorite(context),
                                                          );
                                                        } else {
                                                          return;
                                                        }
                                                      },
                                                    )
                                                : () => (state.mediaState?.favorite ?? false)
                                                    ? showCupertinoModalPopup(
                                                        context: context,
                                                        builder: (secondContext) =>
                                                            CustomBottomSheet(
                                                          title: mediaType == MediaType.movie
                                                              ? '${state.multipleDetails.title} (${(state.multipleDetails.releaseDate ?? '').isNotEmpty ? state.multipleDetails.releaseDate?.substring(0, 4) : 'Unknown'})'
                                                              : '${state.multipleDetails.name} (${(state.multipleDetails.firstAirDate ?? '').isNotEmpty ? state.multipleDetails.firstAirDate?.substring(0, 4) : 'Unknown'} - ${(state.multipleDetails.lastAirDate ?? '').isNotEmpty ? state.multipleDetails.lastAirDate?.substring(0, 4) : 'Unknown'})',
                                                          titleConfirm: 'Remove from Favorites',
                                                          titleCancel: 'Cancel',
                                                          onPressCancel: () =>
                                                              Navigator.of(secondContext).pop(),
                                                          onPressConfirm: () => removeFavorite(
                                                              context, secondContext),
                                                        ),
                                                      )
                                                    : addFavorite(context),
                                            child: Ink(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h, horizontal: 5.w),
                                              child: Icon(
                                                state.mediaState?.favorite ?? false
                                                    ? Icons.favorite_sharp
                                                    : Icons.favorite_outline_sharp,
                                                color: yellowColor,
                                                size: 22.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      mediaType == MediaType.movie
                                          ? '${state.multipleDetails.title} (original title)'
                                          : '${state.multipleDetails.name} (original title)',
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textScaler: const TextScaler.linear(1),
                                      style: TextStyle(
                                        color: greyColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.normal,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      mediaType == MediaType.movie
                                          ? '${(state.multipleDetails.releaseDate ?? '').isNotEmpty ? state.multipleDetails.releaseDate?.substring(0, 4) : 'Unknown'}    K   ${AppUtils().formatRuntime(state.multipleDetails.runtime ?? 0)}'
                                          : 'TV Series  ${(state.multipleDetails.firstAirDate ?? '').isNotEmpty ? state.multipleDetails.firstAirDate?.substring(0, 4) : 'Unknown'} - ${(state.multipleDetails.lastAirDate ?? '').isNotEmpty ? state.multipleDetails.lastAirDate?.substring(0, 4) : 'Unknown'}',
                                      textScaler: const TextScaler.linear(1),
                                      style: TextStyle(
                                        color: greyColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                        height: 0,
                                      ),
                                    ),
                                    // SizedBox(height: 10.h),
                                  ],
                                ),
                              ),
                              CarouselSlider.builder(
                                itemBuilder: itemBuilderImage,
                                itemCount: state.images.length,
                                options: CarouselOptions(
                                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                                  autoPlay: false,
                                  height: 180.h,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: true,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      flex: 2,
                                      child: Material(
                                        color: noColor,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 5.h),
                                            child: Hero(
                                              tag: heroTag ?? '',
                                              child: CachedNetworkImage(
                                                imageUrl: state.multipleDetails.posterPath != null
                                                    ? '${AppConstants.kImagePathPoster}${state.multipleDetails.posterPath}'
                                                    : '',
                                                height: 140.h,
                                                filterQuality: FilterQuality.high,
                                                fit: BoxFit.fill,
                                                progressIndicatorBuilder:
                                                    (context, url, progress) =>
                                                        const CustomIndicator(),
                                                errorWidget: (context, url, error) => Image.asset(
                                                  ImagesPath.noImage.assetName,
                                                  width: double.infinity,
                                                  filterQuality: FilterQuality.high,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Align(
                                        child: Material(
                                          color: noColor,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(0.w, 10.h, 5.w, 10.h),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    SizedBox(width: 15.w),
                                                    Expanded(
                                                      child: Text(
                                                        state.multipleDetails.overview ?? '',
                                                        softWrap: true,
                                                        maxLines: 5,
                                                        overflow: TextOverflow.ellipsis,
                                                        textScaler: const TextScaler.linear(1),
                                                        style: TextStyle(
                                                          color: greyColor,
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.normal,
                                                          height: 1.15.h,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: lightGreyColor,
                                                      size: 15.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 35.h,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(15.w, 2.h, 15.w, 2.h),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: itemBuilderGenres,
                                  separatorBuilder: separatorBuilder,
                                  addRepaintBoundaries: false,
                                  addAutomaticKeepAlives: false,
                                  itemCount: state.multipleDetails.genres.length,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              mediaType == MediaType.tv
                                  ? Material(
                                      color: noColor,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 10.h),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Episode guide',
                                                textScaler: const TextScaler.linear(1),
                                                style: TextStyle(
                                                  color: blackColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${state.multipleDetails.numberOfEpisodes} episodes',
                                                    textScaler: const TextScaler.linear(1),
                                                    style: TextStyle(
                                                      color: greyColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.normal,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: lightGreyColor,
                                                    size: 15.sp,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: gainsBoroColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                child: AddWatchlistButton(
                                  title: state.mediaState?.watchlist ?? false
                                      ? 'Added to Watchlist'
                                      : 'Add to Watchlist',
                                  content: 'Added by 454K users',
                                  buttonStyle: state.mediaState?.watchlist ?? false
                                      ? addWatchlistSecondaryStyle
                                      : addWatchlistPrimaryStyle,
                                  icon: state.mediaState?.watchlist ?? false
                                      ? Icons.check
                                      : Icons.add,
                                  onTap: state.mediaState == null
                                      ? () => Navigator.of(context).pushNamed(
                                            AppMainRoutes.authentication,
                                            arguments: {
                                              'is_later_login': true,
                                            },
                                          ).then(
                                            (value) async => await Future.delayed(
                                              const Duration(seconds: 2),
                                              () => addWatchlist(context),
                                            ),
                                          )
                                      : () => (state.mediaState?.watchlist ?? false)
                                          ? showCupertinoModalPopup(
                                              context: context,
                                              builder: (secondContext) => CustomBottomSheet(
                                                title: mediaType == MediaType.movie
                                                    ? '${state.multipleDetails.title} (${(state.multipleDetails.releaseDate ?? '').isNotEmpty ? state.multipleDetails.releaseDate?.substring(0, 4) : 'Unknown'})'
                                                    : '${state.multipleDetails.name} (${(state.multipleDetails.firstAirDate ?? '').isNotEmpty ? state.multipleDetails.firstAirDate?.substring(0, 4) : 'Unknown'} - ${(state.multipleDetails.lastAirDate ?? '').isNotEmpty ? state.multipleDetails.lastAirDate?.substring(0, 4) : 'Unknown'})',
                                                titleConfirm: 'Remove from Watchlist',
                                                titleCancel: 'Cancel',
                                                onPressCancel: () =>
                                                    Navigator.of(secondContext).pop(),
                                                onPressConfirm: () =>
                                                    removeWatchlist(context, secondContext),
                                              ),
                                            )
                                          : addWatchlist(context),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: gainsBoroColor,
                              ),
                              SizedBox(height: 5.h),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Material(
                                        color: noColor,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(height: 5.h),
                                              Icon(
                                                Icons.star_rounded,
                                                color: yellowColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(height: 3.h),
                                              RichText(
                                                textScaler: const TextScaler.linear(1),
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: double.parse(
                                                              (state.multipleDetails.voteAverage ??
                                                                      0)
                                                                  .toStringAsFixed(1))
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: blackColor,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '/10',
                                                      style: TextStyle(
                                                        color: greyColor,
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.normal,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                state.multipleDetails.voteCount.toString(),
                                                textScaler: const TextScaler.linear(1),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: greyColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Material(
                                        color: noColor,
                                        child: InkWell(
                                          onTap: state.mediaState != null
                                              ? () async => await Navigator.of(context).pushNamed(
                                                    AppMainRoutes.rating,
                                                    arguments: {
                                                      'id': state.multipleDetails.id,
                                                      'title': state.multipleDetails.title ??
                                                          state.multipleDetails.name,
                                                      'image_url': state.multipleDetails.posterPath,
                                                      'value': state.mediaState?.rated is bool?
                                                          ? 0.0
                                                          : (state.mediaState?.rated as Rated?)
                                                              ?.value,
                                                      'media_type': mediaType,
                                                    },
                                                  ).then(
                                                    (value) async => await Future.delayed(
                                                      const Duration(milliseconds: 500),
                                                      () => BlocProvider.of<DetailsBloc>(context)
                                                          .add(FetchState(
                                                        id: id ?? 0,
                                                        mediaType: mediaType ?? MediaType.movie,
                                                      )),
                                                    ),
                                                  )
                                              : () => Navigator.of(context).pushNamed(
                                                    AppMainRoutes.authentication,
                                                    arguments: {
                                                      'is_later_login': true,
                                                    },
                                                  ).then(
                                                    (results) =>
                                                        BlocProvider.of<DetailsBloc>(context)
                                                            .add(FetchDataDetails(
                                                      id: id ?? 0,
                                                      language: 'en-US',
                                                      mediaType: mediaType ?? MediaType.movie,
                                                    )),
                                                  ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(height: 5.h),
                                              Icon(
                                                (state.mediaState?.rated is bool ||
                                                        state.mediaState == null)
                                                    ? Icons.star_outline_rounded
                                                    : Icons.star_rounded,
                                                color: brightNavyBlue,
                                                size: 20.sp,
                                              ),
                                              SizedBox(height: 3.h),
                                              (state.mediaState?.rated is bool ||
                                                      state.mediaState == null)
                                                  ? Text(
                                                      'Rate this',
                                                      textAlign: TextAlign.center,
                                                      textScaler: const TextScaler.linear(1),
                                                      style: TextStyle(
                                                        color: brightNavyBlue,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  : (state.mediaState?.rated is Rated?)
                                                      ? Column(
                                                          children: [
                                                            RichText(
                                                              textScaler:
                                                                  const TextScaler.linear(1),
                                                              textAlign: TextAlign.center,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: double.parse(
                                                                      (state.mediaState?.rated
                                                                                  ?.value ??
                                                                              0)
                                                                          .toStringAsFixed(1),
                                                                    ).ceil().toString(),
                                                                    style: TextStyle(
                                                                      color: blackColor,
                                                                      fontSize: 20.sp,
                                                                      fontWeight: FontWeight.w600,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: '/10',
                                                                    style: TextStyle(
                                                                      color: greyColor,
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.normal,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                              'Your rating',
                                                              textAlign: TextAlign.center,
                                                              textScaler:
                                                                  const TextScaler.linear(1),
                                                              style: TextStyle(
                                                                color: greyColor,
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.normal,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            SizedBox(height: 5.h),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Material(
                                        color: noColor,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 5.h),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: yellowColor,
                                                ),
                                                child: Text(
                                                  double.parse(
                                                    ((state.multipleDetails.voteAverage ?? 0) * 10)
                                                        .ceil()
                                                        .toString(),
                                                  ).toInt().toString(),
                                                  textAlign: TextAlign.center,
                                                  textScaler: const TextScaler.linear(1),
                                                  style: TextStyle(
                                                    color: blackColor,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.normal,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                'Metascore',
                                                textAlign: TextAlign.center,
                                                textScaler: const TextScaler.linear(1),
                                                style: TextStyle(
                                                  color: blackColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.3,
                                                ),
                                              ),
                                              Text(
                                                state.multipleDetails.popularity.toString(),
                                                textAlign: TextAlign.center,
                                                textScaler: const TextScaler.linear(1),
                                                style: TextStyle(
                                                  color: greyColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: whiteSmokeColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 15.h),
                              PrimaryText(
                                paddingLeft: 15.w,
                                paddingRight: 15.w,
                                title: 'Cast & crew',
                                visibleIcon: true,
                                enableRightWidget: false,
                                onTapViewAll: () {},
                                icon: SvgPicture.asset(
                                  IconsPath.artistIcon.assetName,
                                  width: 24,
                                ),
                              ),
                              state.cast.isNotEmpty
                                  ? SizedBox(
                                      height: 195.h,
                                      child: ListView.separated(
                                        addAutomaticKeepAlives: false,
                                        addRepaintBoundaries: false,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: itemBuilderCast,
                                        separatorBuilder: separatorBuilder,
                                        itemCount: state.cast.take(20).toList().length,
                                      ),
                                    )
                                  : SizedBox(height: 10.h),
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: gainsBoroColor,
                              ),
                              Material(
                                color: noColor,
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                    child: RichText(
                                      textScaler: const TextScaler.linear(1),
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Directors: ',
                                            style: TextStyle(
                                              color: blackColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: getDirector(context),
                                            style: TextStyle(
                                              color: greyColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: gainsBoroColor,
                              ),
                              Material(
                                color: noColor,
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                    child: RichText(
                                      textScaler: const TextScaler.linear(1),
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Writer: ',
                                            style: TextStyle(
                                              color: blackColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: getWriter(context),
                                            style: TextStyle(
                                              color: greyColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: gainsBoroColor,
                              ),
                              state.cast.isEmpty && state.crew.isEmpty
                                  ? const SizedBox()
                                  : Material(
                                      color: noColor,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 10.h),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                mediaType == MediaType.movie
                                                    ? 'All cast & crew'
                                                    : 'Series cast & crew',
                                                textScaler: const TextScaler.linear(1),
                                                style: TextStyle(
                                                  color: blackColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: lightGreyColor,
                                                size: 15.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        RelatedView(
                          id: id,
                          mediaType: mediaType,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilderImage(BuildContext context, int index, int realIndex) {
    final bloc = BlocProvider.of<DetailsBloc>(context);
    final item = bloc.state.images.isNotEmpty ? bloc.state.images[index] : null;
    return CachedNetworkImage(
      imageUrl: item?.filePath != null ? '${AppConstants.kImagePathBackdrop}${item?.filePath}' : '',
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
      errorWidget: (context, url, error) => Image.asset(
        ImagesPath.noImage.assetName,
        width: double.infinity,
        filterQuality: FilterQuality.high,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget itemBuilderGenres(BuildContext context, int index) {
    final bloc = BlocProvider.of<DetailsBloc>(context);
    final item = bloc.state.multipleDetails.genres[index];
    return Material(
      color: noColor,
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                '${item.name}',
                maxLines: 1,
                textScaler: const TextScaler.linear(1),
                style: TextStyle(
                  color: blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.arrow_forward_ios,
                shadows: [
                  BoxShadow(
                    blurRadius: 5,
                    color: whiteColor,
                  ),
                ],
                color: blackColor,
                size: 8.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuilderCast(BuildContext context, int index) {
    final bloc = BlocProvider.of<DetailsBloc>(context);
    final item = bloc.state.cast[index];
    return GestureDetector(
      onTap: () {},
      child: RepaintBoundary(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: 75.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    BoxShadow(
                      color: lightGreyColor,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: '${AppConstants.kImagePathProfile}${item.profilePath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    getErrorImageWithGender(item.gender ?? 0),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: 70.w,
                child: Text(
                  '${item.name}',
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 0,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: 75.w,
                child: Text(
                  '${item.character}',
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 12.sp,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 10.w);

  addFavorite(BuildContext context) {
    final bloc = BlocProvider.of<DetailsBloc>(context);
    bloc.add(AddFavorites(
      mediaType: mediaType == MediaType.movie ? 'movie' : 'tv',
      mediaId: bloc.state.multipleDetails.id ?? 0,
    ));
  }

  removeFavorite(BuildContext firstContext, BuildContext secondContext) {
    addFavorite(firstContext);
    Navigator.of(secondContext).pop();
  }

  addWatchlist(BuildContext context) {
    final bloc = BlocProvider.of<DetailsBloc>(context);
    bloc.add(AddWatchlist(
      mediaType: mediaType == MediaType.movie ? 'movie' : 'tv',
      mediaId: bloc.state.multipleDetails.id ?? 0,
    ));
  }

  removeWatchlist(BuildContext firstContext, BuildContext secondContext) {
    addWatchlist(firstContext);
    Navigator.of(secondContext).pop();
  }

  String getErrorImageWithGender(int gender) {
    switch (gender) {
      case 0:
        {
          return ImagesPath.noImageMan.assetName;
        }
      case 1:
        {
          return ImagesPath.noImageWoman.assetName;
        }
      default:
        {
          return ImagesPath.noImageOtherGender.assetName;
        }
    }
  }
}

String getDirector(BuildContext context) {
  final state = BlocProvider.of<DetailsBloc>(context).state;
  if (state.crew.isNotEmpty) {
    final directors = state.crew
        .where((element) => (element.knownForDepartment ?? '').contains('Directing'))
        .toList();
    if (directors.isNotEmpty) {
      if (directors.length > 1) {
        return '${directors.first.name} and ${directors.length - 1} other';
      } else {
        return directors.first.name ?? 'Unknown';
      }
    } else {
      return 'Unknown';
    }
  } else {
    return 'Unknown';
  }
}

String getWriter(BuildContext context) {
  final state = BlocProvider.of<DetailsBloc>(context).state;
  if (state.crew.isNotEmpty) {
    final writers =
        state.crew.where((element) => (element.knownForDepartment ?? '').contains('Writing'));
    if (writers.isNotEmpty) {
      return writers
              .reduce(
                (value, element) =>
                    (value.popularity ?? 0.0) > (element.popularity ?? 0.0) ? value : element,
              )
              .name ??
          'Unknown';
    } else {
      return 'Unknown';
    }
  } else {
    return 'Unknown';
  }
}
