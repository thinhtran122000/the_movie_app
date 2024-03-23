import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NonaryItem extends StatefulWidget {
  final String? title;
  final String imageUrl;
  final String? nameOfTrailer;
  final ObjectKey? youtubeKey;
  final bool enableVideo;
  final String videoId;
  final String heroTag;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapVideo;
  final VoidCallback? onTapFullScreen;
  final YoutubePlayerController controller;
  final Function(YoutubeMetaData)? onEnded;

  const NonaryItem({
    super.key,
    this.onTapItem,
    this.title,
    this.nameOfTrailer,
    this.onEnded,
    this.onTapVideo,
    this.youtubeKey,
    this.onTapFullScreen,
    required this.videoId,
    required this.controller,
    required this.imageUrl,
    required this.enableVideo,
    required this.heroTag,
  });

  @override
  State<NonaryItem> createState() => _NonaryItemState();
}

class _NonaryItemState extends State<NonaryItem> {
  int remaningDuration = 0;
  int currentPosition = 0;
  bool enabledSound = true;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.enableVideo ? null : widget.onTapVideo,
            behavior: HitTestBehavior.deferToChild,
            child: Container(
              width: 325.w,
              height: 180.h,
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
              child: widget.enableVideo
                  ? Hero(
                      tag: widget.heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: YoutubePlayer(
                          width: 325.w,
                          onEnded: widget.onEnded,
                          key: widget.youtubeKey,
                          controller: enabledSound
                              ? (widget.controller
                                ..addListener(
                                  () => setState(
                                    () {
                                      remaningDuration =
                                          widget.controller.value.metaData.duration.inMilliseconds;
                                      currentPosition =
                                          widget.controller.value.position.inMilliseconds;
                                    },
                                  ),
                                )
                                ..unMute())
                              : (widget.controller
                                ..addListener(
                                  () => setState(
                                    () {
                                      remaningDuration =
                                          widget.controller.value.metaData.duration.inMilliseconds;
                                      currentPosition =
                                          widget.controller.value.position.inMilliseconds;
                                    },
                                  ),
                                )
                                ..mute()),
                          progressColors: ProgressBarColors(
                            playedColor: whiteColor,
                            handleColor: whiteColor,
                            backgroundColor: greyColor,
                            bufferedColor: greyColor.withOpacity(0.5),
                          ),
                          bottomActions: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 310.w,
                                  child: ProgressBar(
                                    controller: widget.controller,
                                    colors: ProgressBarColors(
                                      playedColor: whiteColor,
                                      handleColor: whiteColor,
                                      backgroundColor: whiteColor.withOpacity(0.2),
                                      bufferedColor: greyColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() => enabledSound = !enabledSound);
                                          enabledSound
                                              ? widget.controller.setVolume(100)
                                              : widget.controller.setVolume(0);
                                        },
                                        child: Icon(
                                          enabledSound ? Icons.volume_up : Icons.volume_off,
                                          color: whiteColor,
                                          size: 20.sp,
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      GestureDetector(
                                        onTap: () => widget.controller.seekTo(
                                          Duration(milliseconds: currentPosition - 10000),
                                        ),
                                        child: SvgPicture.asset(
                                          IconsPath.backwardIcon.assetName,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      GestureDetector(
                                        onTap: () => widget.controller.seekTo(
                                          Duration(milliseconds: currentPosition + 10000),
                                        ),
                                        child: SvgPicture.asset(
                                          IconsPath.forwardIcon.assetName,
                                          width: 15.w,
                                          height: 15.h,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      SizedBox(
                                        width: 80.w,
                                        child: Text(
                                          '${AppUtils().durationFormatter(currentPosition)} / ${AppUtils().durationFormatter(remaningDuration)}',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 50.w),
                                      PopupMenuButton<double>(
                                        color: blackColor.withOpacity(0.5),
                                        surfaceTintColor: whiteColor,
                                        position: PopupMenuPosition.over,
                                        padding: EdgeInsets.zero,
                                        offset: const Offset(0, -250),
                                        onSelected: (value) =>
                                            widget.controller.setPlaybackRate(value),
                                        icon: SvgPicture.asset(
                                          IconsPath.playbackSpeedIcon.assetName,
                                          height: 20.h,
                                        ),
                                        itemBuilder: itemBuilder,
                                      ),
                                      GestureDetector(
                                        onTap: widget.onTapFullScreen,
                                        child: Icon(
                                          Icons.fullscreen,
                                          size: 22.sp,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
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
                                    width: double.infinity,
                                    height: double.infinity,
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
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: widget.heroTag,
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
          SizedBox(height: 5.h),
          InkWell(
            onTap: widget.onTapItem,
            child: SizedBox(
              width: 300.w,
              child: Text(
                '${widget.title} - ${widget.nameOfTrailer}',
                softWrap: true,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  List<double> playbackRate = [
    PlaybackRate.quarter,
    PlaybackRate.half,
    PlaybackRate.threeQuarter,
    PlaybackRate.normal,
    PlaybackRate.oneAndAQuarter,
    PlaybackRate.oneAndAHalf,
    PlaybackRate.oneAndAThreeQuarter,
    PlaybackRate.twice,
  ];

  List<PopupMenuItem<double>> itemBuilder(BuildContext context) => playbackRate
      .map<PopupMenuItem<double>>(
        (e) => PopupMenuItem(
          height: 25.h,
          value: e,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.controller.value.playbackRate == e ? Icons.check_circle : null,
                color: whiteColor,
                size: 15.sp,
              ),
              SizedBox(width: 5.w),
              Text(
                e == PlaybackRate.normal ? 'Normal' : '$e',
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      )
      .toList();
}
