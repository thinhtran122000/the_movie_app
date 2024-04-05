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
  final double? scrollPosition;
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
    this.scrollPosition,
    required this.videoId,
    required this.controller,
    required this.imageUrl,
    required this.enableVideo,
    required this.heroTag,
  });

  @override
  State<NonaryItem> createState() => _NonaryItemState();
}

class _NonaryItemState extends State<NonaryItem> with AutomaticKeepAliveClientMixin {
  int remaningDuration = 0;
  int currentPosition = 0;
  bool enabledSound = false;
  bool enabledUnmute = true;
  bool clickable = false;
  bool clickableSound = true;
  bool displayColor = true;
  bool enabledText = true;
  late Timer timer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 0), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(17.h, 5.h, 17.h, 5.h),
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
                          fit: StackFit.expand,
                          alignment: Alignment.bottomCenter,
                          children: [
                            GestureDetector(
                              onTap: () => showHideControl(
                                isPlaying: widget.controller.value.isPlaying,
                                clickType: ClickPosition.outside,
                              ),
                              child: YoutubePlayer(
                                onEnded: widget.onEnded,
                                key: widget.youtubeKey,
                                controller: enabledSound
                                    ? (widget.controller
                                      ..addListener(
                                        () {
                                          setState(
                                            () {
                                              remaningDuration = widget.controller.value.metaData
                                                  .duration.inMilliseconds;
                                              currentPosition =
                                                  widget.controller.value.position.inMilliseconds;
                                            },
                                          );
                                          (widget.scrollPosition ?? 0) >= 1100.h &&
                                                  (widget.scrollPosition ?? 0) <= 1500.h
                                              ? null
                                              : widget.controller.pause();
                                        },
                                      )
                                      ..unMute()
                                      ..setPlaybackRate(widget.controller.value.playbackRate))
                                    : (widget.controller
                                      ..addListener(
                                        () => setState(
                                          () {
                                            remaningDuration = widget
                                                .controller.value.metaData.duration.inMilliseconds;
                                            currentPosition =
                                                widget.controller.value.position.inMilliseconds;
                                            (widget.scrollPosition ?? 0) >= 1100.h &&
                                                    (widget.scrollPosition ?? 0) <= 1500.h
                                                ? null
                                                : widget.controller.pause();
                                          },
                                        ),
                                      )
                                      ..mute()
                                      ..setPlaybackRate(widget.controller.value.playbackRate)),
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
                              ignoreButton: !clickable,
                              controller: widget.controller,
                              videoId: widget.videoId,
                              opacity: clickable ? 1.0 : 0.0,
                              onTapButton: () {
                                widget.controller.value.isPlaying
                                    ? widget.controller.pause()
                                    : widget.controller.play();
                                showHideControl(
                                  isPlaying: widget.controller.value.isPlaying,
                                  clickType: ClickPosition.inside,
                                );
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomProgressBar(
                                  opacity: clickable ? 1.0 : 0.0,
                                  ignoreButton: !clickable,
                                  controller: widget.controller,
                                  onSeek: (event) => showHideControl(
                                    isPlaying: widget.controller.value.isPlaying,
                                    clickType: ClickPosition.inside,
                                  ),
                                  onTap: (event) {
                                    print('Hello 1 $clickable');
                                    showHideControl(
                                      isPlaying: widget.controller.value.isPlaying,
                                      clickType: ClickPosition.inside,
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // SizedBox(width: 20.w),
                                      CustomVolumeButton(
                                        ignoreButton: !clickableSound,
                                        opacity: clickableSound ? 1.0 : 0.0,
                                        enabledUnmute: enabledUnmute,
                                        controller: widget.controller,
                                        colorButton: displayColor
                                            ? greyColor.withOpacity(0.5)
                                            : Colors.transparent,
                                        width: widget.controller.value.isPlaying
                                            ? null
                                            : enabledUnmute
                                                ? 0
                                                : null,
                                        icon: enabledSound
                                            ? Icons.volume_down_rounded
                                            : Icons.volume_mute_rounded,
                                        onTapButton: () {
                                          showHideControl(
                                            isPlaying: widget.controller.value.isPlaying,
                                            clickType: ClickPosition.inside,
                                          );
                                          setState(() => enabledSound = !enabledSound);
                                          enabledSound
                                              ? widget.controller.setVolume(100)
                                              : widget.controller.setVolume(0);
                                        },
                                      ),
                                      SizedBox(width: 10.w),
                                      Flexible(
                                        flex: 1,
                                        child: CustomSeekButton(
                                          opacity: clickable ? 1.0 : 0.0,
                                          ignoreButton: !clickable,
                                          imagePath: IconsPath.backwardIcon.assetName,
                                          onTapButton: () {
                                            showHideControl(
                                              isPlaying: widget.controller.value.isPlaying,
                                              clickType: ClickPosition.inside,
                                            );
                                            widget.controller.seekTo(
                                              Duration(milliseconds: currentPosition - 10000),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      Flexible(
                                        flex: 1,
                                        child: CustomSeekButton(
                                          ignoreButton: !clickable,
                                          opacity: clickable ? 1.0 : 0.0,
                                          imagePath: IconsPath.forwardIcon.assetName,
                                          onTapButton: () {
                                            showHideControl(
                                              isPlaying: widget.controller.value.isPlaying,
                                              clickType: ClickPosition.inside,
                                            );
                                            widget.controller.seekTo(
                                              Duration(milliseconds: currentPosition + 10000),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      AnimatedOpacity(
                                        opacity: clickable ? 1.0 : 0.0,
                                        duration: const Duration(milliseconds: 300),
                                        child: Text(
                                          '${AppUtils().durationFormatter(currentPosition)} / ${AppUtils().durationFormatter(remaningDuration)}',
                                          textAlign: TextAlign.start,
                                          textScaler: const TextScaler.linear(1),
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: 50.w),
                                      const Spacer(flex: 2),
                                      Flexible(
                                        flex: 1,
                                        child: CustomSpeedButton(
                                          ignoreButton: !clickable,
                                          opacity: clickable ? 1.0 : 0.0,
                                          controller: widget.controller,
                                          onSelected: (value) =>
                                              widget.controller.setPlaybackRate(value),
                                          onOpened: () => showHideControl(
                                            isPlaying: widget.controller.value.isPlaying,
                                            clickType: ClickPosition.inside,
                                            isPlaybackSpeedOpened: true,
                                          ),
                                          onCanceled: () => setState(
                                            () => timer = Timer(
                                              const Duration(seconds: 1),
                                              () {
                                                clickable = false;
                                                clickableSound = false;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      Flexible(
                                        flex: 1,
                                        child: CustomSpeedButton(
                                          ignoreButton: !clickable,
                                          opacity: clickable ? 1.0 : 0.0,
                                          controller: widget.controller,
                                          onSelected: (value) =>
                                              widget.controller.setPlaybackRate(value),
                                          onOpened: () => showHideControl(
                                            isPlaying: widget.controller.value.isPlaying,
                                            clickType: ClickPosition.inside,
                                            isPlaybackSpeedOpened: true,
                                          ),
                                          onCanceled: () => setState(
                                            () => timer = Timer(
                                              const Duration(seconds: 1),
                                              () {
                                                clickable = false;
                                                clickableSound = false;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: widget.enableVideo ? null : widget.onTapVideo,
                      child: Stack(
                        fit: StackFit.expand,
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
          ),
          SizedBox(height: 5.h),
          InkWell(
            onTap: widget.onTapItem,
            child: SizedBox(
              width: 300.w,
              child: Text(
                '${widget.title} - ${widget.nameOfTrailer}',
                softWrap: true,
                textScaler: const TextScaler.linear(1),
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
    widget.controller.value.webViewController?.dispose();

    super.dispose();
  }

  showHideControl({
    required bool isPlaying,
    required ClickPosition clickType,
    bool isPlaybackSpeedOpened = false,
  }) {
    if (clickType == ClickPosition.inside) {
      setState(() {
        enabledUnmute = false;
        clickableSound = true;
        displayColor = false;
      });
      if (isPlaying) {
        setState(() {
          clickable = true;
          clickableSound = true;
        });
        if (clickable) {
          if (isPlaybackSpeedOpened) {
            timer.cancel();
            setState(() => clickable = true);
          } else {
            setState(() {
              timer.cancel();
              timer = Timer(
                const Duration(seconds: 2),
                () {
                  clickable = false;
                  clickableSound = false;
                },
              );
            });
          }
        }
      } else {
        setState(() {
          clickable = true;
          clickableSound = true;
          timer.cancel();
          timer = Timer(
            const Duration(seconds: 2),
            () {
              clickable = false;
              clickableSound = false;
            },
          );
        });
      }
    } else {
      setState(() {
        displayColor = false;
        enabledUnmute = false;
        clickable = !clickable;
        clickableSound = clickable ? true : !clickableSound;
      });
      if (isPlaying) {
        if (clickable) {
          setState(() {
            timer.cancel();
            timer = Timer(
              const Duration(seconds: 2),
              () {
                clickable = false;
                clickableSound = false;
              },
            );
          });
        }
      } else {
        return;
      }
    }
  }
}

enum ClickPosition {
  inside,
  outside,
}
