import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/details/views/related/bloc/related_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class RelatedView extends StatelessWidget {
  final int? id;
  final MediaType? mediaType;
  const RelatedView({
    super.key,
    this.id,
    this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RelatedBloc()
        ..add(FetchDataRelated(
          id: id ?? 0,
          page: 1,
          language: 'en-US',
          mediaType: mediaType ?? MediaType.movie,
        )),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TmdbBloc, TmdbState>(
            listener: (context, state) {
              if (state is TmdbWatchlistSuccess) {
                BlocProvider.of<RelatedBloc>(context).add(FetchDataRelated(
                  id: id ?? 0,
                  mediaType: mediaType ?? MediaType.movie,
                  page: 1,
                  language: 'en-US',
                ));
              }
            },
          ),
          BlocListener<RelatedBloc, RelatedState>(
            listener: (context, state) {
              if (state is RelatedAddWatchlistSuccess) {
                BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                  notificationTypes: NotificationTypes.watchlist,
                ));
              }
            },
          ),
        ],
        child: BlocBuilder<RelatedBloc, RelatedState>(
          builder: (context, state) {
            return Container(
              color: whiteSmokeColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15.h),
                  PrimaryText(
                    title: 'More like this',
                    paddingLeft: 15.w,
                    paddingRight: 15.w,
                    visibleIcon: true,
                    onTapViewAll: () {},
                    icon: SvgPicture.asset(
                      IconsPath.relatedIcon.assetName,
                      fit: BoxFit.scaleDown,
                      width: 20.w,
                    ),
                  ),
                  SizedBox(
                    height: 250.h,
                    child: ListView.separated(
                      // controller: bloc.scrollController,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 20.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilderRelated,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listRelated.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilderRelated(BuildContext context, int index) {
    final bloc = BlocProvider.of<RelatedBloc>(context);
    final item = bloc.state.listRelated[index];
    final itemState = bloc.state.listState.isNotEmpty ? bloc.state.listState[index] : null;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppMainRoutes.details,
        arguments: {
          'id': item.id,
          'hero_tag': '${AppConstants.relatedTag}-${item.id}',
          'media_type': mediaType,
        },
      ),
      child: RepaintBoundary(
        child: Container(
          width: 115.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: '${AppConstants.relatedTag}-${item.id}',
                      child: CachedNetworkImage(
                        imageUrl: '${AppConstants.kImagePathPoster}${item.posterPath}',
                        filterQuality: FilterQuality.high,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CustomIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          ImagesPath.noImage.assetName,
                          width: double.infinity,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: bloc.state.listState.isNotEmpty
                            ? () => (itemState?.watchlist ?? false)
                                ? showCupertinoModalPopup(
                                    context: context,
                                    builder: (secondContext) => CustomBottomSheet(
                                      title: mediaType == MediaType.movie
                                          ? '${item.title} (${(item.releaseDate ?? '').isNotEmpty ? item.releaseDate?.substring(0, 4) : 'Unknown'})'
                                          : '${item.name} (${(item.firstAirDate ?? '').isNotEmpty ? item.firstAirDate?.substring(0, 4) : 'Unknown'})',
                                      titleConfirm: 'Remove from Watchlist',
                                      titleCancel: 'Cancel',
                                      onPressCancel: () => Navigator.of(secondContext).pop(),
                                      onPressConfirm: () =>
                                          removeWatchlist(context, secondContext, index),
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
                                      bloc.add(FetchDataRelated(
                                        id: id ?? 0,
                                        page: 1,
                                        language: 'en-US',
                                        mediaType: mediaType ?? MediaType.movie,
                                      ));
                                      await Future.delayed(
                                        const Duration(seconds: 2),
                                        () => addWatchlist(context, index),
                                      );
                                    }
                                  },
                                ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              (itemState?.watchlist ?? false)
                                  ? IconsPath.addedWatchListIcon.assetName
                                  : IconsPath.addWatchListIcon.assetName,
                              alignment: Alignment.topLeft,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 5.h,
                              child: Icon(
                                (itemState?.watchlist ?? false) ? Icons.check : Icons.add,
                                color: (itemState?.watchlist ?? false) ? blackColor : whiteColor,
                                size: 22.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: blackColor.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            (itemState?.favorite ?? false)
                                ? Icons.favorite_sharp
                                : Icons.favorite_outline_sharp,
                            color: (itemState?.favorite ?? false) ? yellowColor : whiteColor,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: yellowColor,
                      size: 15.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${item.voteAverage?.toStringAsFixed(1)}',
                      maxLines: 1,
                      softWrap: false,
                      textScaler: const TextScaler.linear(1),
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 12.sp,
                        overflow: TextOverflow.clip,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  mediaType == MediaType.movie ? '${item.title}' : '${item.name}',
                  maxLines: 1,
                  softWrap: false,
                  textScaler: const TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 10.w);

  addWatchlist(BuildContext context, int index) {
    final bloc = BlocProvider.of<RelatedBloc>(context);
    bloc.add(AddWatchList(
      mediaType: mediaType == MediaType.movie ? 'movie' : 'tv',
      mediaId: bloc.state.listRelated[index].id ?? 0,
      index: index,
    ));
  }

  removeWatchlist(BuildContext firstContext, BuildContext secondContext, int index) {
    addWatchlist(firstContext, index);
    Navigator.of(secondContext).pop();
  }
}
