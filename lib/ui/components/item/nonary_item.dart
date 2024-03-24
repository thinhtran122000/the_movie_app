import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool clickable = false;
  late Timer timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 2), () => clickable = false);
    super.initState();
  }

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
              height: 200.h,
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
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned.fill(
                              child: YoutubePlayer(
                                width: 325.w,
                                onEnded: widget.onEnded,
                                key: widget.youtubeKey,
                                controller: enabledSound
                                    ? (widget.controller
                                      ..addListener(
                                        () => setState(
                                          () {
                                            remaningDuration = widget
                                                .controller.value.metaData.duration.inMilliseconds;
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
                                            remaningDuration = widget
                                                .controller.value.metaData.duration.inMilliseconds;
                                            currentPosition =
                                                widget.controller.value.position.inMilliseconds;
                                          },
                                        ),
                                      )
                                      ..mute()),
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
                            CustomPlayButton(
                              controller: widget.controller,
                              opacity: clickable ? 1.0 : 0.0,
                              clickable: clickable,
                              onTapOutside: () => showHideControl(
                                  widget.controller.value.isPlaying, ClickPosition.outside),
                              onTapButton: () {
                                widget.controller.value.isPlaying
                                    ? setState(() => clickable = true)
                                    : setState(() => clickable = false);
                                widget.controller.value.isPlaying
                                    ? widget.controller.pause()
                                    : widget.controller.play();
                              },
                            ),
                            AnimatedOpacity(
                              opacity: clickable ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: clickable
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomProgressBar(
                                          controller: widget.controller,
                                          onSeek: (event) => showHideControl(
                                              widget.controller.value.isPlaying,
                                              ClickPosition.inside),
                                          onTap: (event) => showHideControl(
                                              widget.controller.value.isPlaying,
                                              ClickPosition.inside),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomVideoButton(
                                                icon: enabledSound
                                                    ? Icons.volume_up
                                                    : Icons.volume_off,
                                                onTapButton: () {
                                                  showHideControl(widget.controller.value.isPlaying,
                                                      ClickPosition.inside);
                                                  setState(() => enabledSound = !enabledSound);
                                                  enabledSound
                                                      ? widget.controller.setVolume(100)
                                                      : widget.controller.setVolume(0);
                                                },
                                              ),
                                              SizedBox(width: 20.w),
                                              CustomSeekButton(
                                                imagePath: IconsPath.backwardIcon.assetName,
                                                onTapButton: () {
                                                  showHideControl(widget.controller.value.isPlaying,
                                                      ClickPosition.inside);
                                                  widget.controller.seekTo(
                                                    Duration(milliseconds: currentPosition - 10000),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 15.w),
                                              CustomSeekButton(
                                                imagePath: IconsPath.forwardIcon.assetName,
                                                onTapButton: () {
                                                  showHideControl(widget.controller.value.isPlaying,
                                                      ClickPosition.inside);
                                                  widget.controller.seekTo(
                                                    Duration(milliseconds: currentPosition + 10000),
                                                  );
                                                },
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
                                              CustomSpeedButton(
                                                controller: widget.controller,
                                                onSelected: (value) =>
                                                    widget.controller.setPlaybackRate(value),
                                              ),
                                              CustomVideoButton(
                                                icon: Icons.fullscreen,
                                                size: 22.sp,
                                                onTapButton: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                          ],
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
                        Icon(
                          Icons.play_arrow_rounded,
                          color: whiteColor,
                          size: 50.sp,
                          shadows: [
                            BoxShadow(
                              color: greyColor,
                              blurRadius: 5,
                            ),
                          ],
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

  showHideControl(bool isPlaying, ClickPosition clickType) {
    if (clickType == ClickPosition.inside) {
      if (isPlaying) {
        setState(() => clickable = true);
        if (clickable) {
          setState(() {
            timer.cancel();
            timer = Timer(
              const Duration(seconds: 2),
              () => clickable = false,
            );
          });
        }
      } else {
        setState(() => clickable = true);
      }
    } else {
      if (isPlaying) {
        setState(() => clickable = !clickable);
        if (clickable) {
          setState(() {
            timer.cancel();
            timer = Timer(
              const Duration(seconds: 2),
              () => clickable = false,
            );
          });
        }
      } else {
        setState(() => clickable = true);
      }
    }
  }
}

enum ClickPosition {
  inside,
  outside,
}
