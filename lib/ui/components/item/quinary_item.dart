import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuinaryItem extends StatefulWidget {
  final String? title;
  final String? releaseDate;
  final String? overview;
  final double? voteAverage;
  final String imageUrl;
  final String videoId;
  final String? type;
  final ObjectKey? youtubeKey;
  final bool enableVideo;
  final YoutubePlayerController controller;
  final VoidCallback? onTapVideo;
  final VoidCallback? onTapItem;
  final Function(YoutubeMetaData)? onEnded;

  const QuinaryItem({
    super.key,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.overview,
    this.onEnded,
    this.youtubeKey,
    this.onTapVideo,
    this.onTapItem,
    this.type,
    required this.videoId,
    required this.controller,
    required this.imageUrl,
    required this.enableVideo,
  });

  @override
  State<QuinaryItem> createState() => _QuinaryItemState();
}

class _QuinaryItemState extends State<QuinaryItem> {
  @override
  Widget build(BuildContext context) {
    double width = 325.w;
    return RepaintBoundary(
      child: Center(
        child: Container(
          width: width,
          height: 340.h,
          margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: greyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: widget.enableVideo ? null : widget.onTapVideo,
                behavior: HitTestBehavior.deferToChild,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: greyColor,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  height: 180.h,
                  width: double.infinity,
                  child: widget.enableVideo
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: YoutubePlayer(
                            onEnded: widget.onEnded,
                            key: widget.youtubeKey,
                            controller: widget.controller,
                            progressColors: ProgressBarColors(
                              playedColor: whiteColor,
                              handleColor: whiteColor,
                              backgroundColor: greyColor,
                              bufferedColor: greyColor.withOpacity(0.5),
                            ),
                            thumbnail: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.imageUrl,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder: (context, url, progress) =>
                                        const CustomIndicator(),
                                    errorWidget: (context, url, error) => Image.asset(
                                      ImagesPath.noImage.assetName,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: widget.videoId.isNotEmpty
                                      ? const SizedBox()
                                      : BackdropFilter(
                                          blendMode: BlendMode.src,
                                          filter: ImageFilter.blur(
                                            sigmaX: 8,
                                            sigmaY: 8,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                                            alignment: Alignment.center,
                                            color: blackColor.withOpacity(0.6),
                                            child: Text(
                                              '''${widget.title} is comming soon on TMDb''',
                                              textAlign: TextAlign.center,
                                              textScaler: const TextScaler.linear(1),
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrl,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                  progressIndicatorBuilder: (context, url, progress) =>
                                      const CustomIndicator(),
                                  errorWidget: (context, url, error) => Image.asset(
                                    ImagesPath.noImage.assetName,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Icon(
                                  Icons.play_arrow,
                                  color: whiteColor,
                                  size: 60.sp,
                                  shadows: [
                                    BoxShadow(
                                      color: greyColor,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              InkWell(
                onTap: widget.onTapItem,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250.w,
                            child: Text(
                              '${widget.title}',
                              softWrap: true,
                              textScaler: const TextScaler.linear(1),
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 20.sp,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                IconsPath.addWatchListIcon.assetName,
                                width: 29.w,
                                height: 29.h,
                                colorFilter: ColorFilter.mode(
                                  blackColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Positioned.fill(
                                bottom: 4.h,
                                child: Icon(
                                  Icons.add,
                                  color: whiteColor,
                                  size: 21.sp,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        '${widget.releaseDate} ${widget.type}',
                        textScaler: const TextScaler.linear(1),
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: blackColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: 300.w,
                        height: 50.h,
                        child: Text(
                          '${widget.overview}',
                          textScaler: const TextScaler.linear(1),
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: greyColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: yellowColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '${widget.voteAverage}',
                            maxLines: 1,
                            softWrap: false,
                            textScaler: const TextScaler.linear(1),
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16.sp,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.favorite_outline,
                            color: blackColor,
                            size: 25.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
