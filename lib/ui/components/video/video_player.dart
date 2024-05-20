import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPLayer extends StatefulWidget {
  final String? title;
  final String imageUrl;
  final ObjectKey? youtubeKey;
  final bool enableVideo;
  final String videoId;
  final String heroTag;
  final double? scrollPosition;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapVideo;
  final VoidCallback? onTapFullScreen;
  final Function(YoutubeMetaData)? onEnded;
  const VideoPLayer({
    super.key,
    this.scrollPosition,
    this.onTapItem,
    this.onTapVideo,
    this.onTapFullScreen,
    this.onEnded,
    this.title,
    this.youtubeKey,
    required this.videoId,
    required this.imageUrl,
    required this.enableVideo,
    required this.heroTag,
  });

  @override
  State<VideoPLayer> createState() => _VideoPLayerState();
}

class _VideoPLayerState extends State<VideoPLayer> {
  int remaningDuration = 0;
  int currentPosition = 0;
  bool enabledSound = false;
  bool enabledUnmute = true;
  bool clickable = false;
  bool clickableSound = true;
  bool displayColor = true;
  bool enabledText = true;
  late Timer timer;
  late YoutubePlayerController controller;
  @override
  void initState() {
    print('Video initialized');
    timer = Timer(const Duration(seconds: 0), () {});
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        hideControls: true,
        autoPlay: widget.enableVideo ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        controlsVisibleAtStart: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() async {
    print('Video disposed ');
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: () => showHideControl(
                isPlaying: controller.value.isPlaying,
                clickType: ClickPosition.outside,
              ),
              child: YoutubePlayer(
                onEnded: widget.onEnded,
                key: widget.youtubeKey,
                controller: enabledSound
                    ? (controller
                      ..addListener(
                        () {
                          setState(
                            () {
                              remaningDuration = controller.value.metaData.duration.inMilliseconds;
                              currentPosition = controller.value.position.inMilliseconds;
                            },
                          );
                          (widget.scrollPosition ?? 0) >= 1100 &&
                                  (widget.scrollPosition ?? 0) <= 1550
                              ? null
                              : controller.pause();
                        },
                      )
                      ..unMute()
                      ..setPlaybackRate(controller.value.playbackRate)
                      ..setVolume(100))
                    : (controller
                      ..addListener(
                        () {
                          setState(
                            () {
                              remaningDuration = controller.value.metaData.duration.inMilliseconds;
                              currentPosition = controller.value.position.inMilliseconds;
                            },
                          );
                          (widget.scrollPosition ?? 0) >= 1100 &&
                                  (widget.scrollPosition ?? 0) <= 1550
                              ? null
                              : controller.pause();
                        },
                      )
                      ..mute()
                      ..setPlaybackRate(controller.value.playbackRate)
                      ..setVolume(0)),
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
              controller: controller,
              videoId: widget.videoId,
              opacity: clickable ? 1.0 : 0.0,
              onTapButton: () {
                controller.value.isPlaying ? controller.pause() : controller.play();
                showHideControl(
                  isPlaying: controller.value.isPlaying,
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
                  controller: controller,
                  onSeek: (event) => showHideControl(
                    isPlaying: controller.value.isPlaying,
                    clickType: ClickPosition.inside,
                  ),
                  onTap: (event) => showHideControl(
                    isPlaying: controller.value.isPlaying,
                    clickType: ClickPosition.inside,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomVolumeButton(
                        ignoreButton: !clickableSound,
                        opacity: clickableSound ? 1.0 : 0.0,
                        enabledUnmute: enabledUnmute,
                        controller: controller,
                        colorButton: displayColor ? greyColor.withOpacity(0.5) : Colors.transparent,
                        width: controller.value.isPlaying
                            ? null
                            : enabledUnmute
                                ? 0
                                : null,
                        icon: SvgPicture.asset(
                          enabledSound
                              ? IconsPath.volumeOnIcon.assetName
                              : IconsPath.volumeOffIcon.assetName,
                          fit: BoxFit.scaleDown,
                          width: 24.w,
                        ),
                        onTapButton: () {
                          showHideControl(
                            isPlaying: controller.value.isPlaying,
                            clickType: ClickPosition.inside,
                          );
                          setState(() => enabledSound = !enabledSound);
                          enabledSound ? controller.setVolume(100) : controller.setVolume(0);
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
                              isPlaying: controller.value.isPlaying,
                              clickType: ClickPosition.inside,
                            );
                            controller.seekTo(
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
                              isPlaying: controller.value.isPlaying,
                              clickType: ClickPosition.inside,
                            );
                            controller.seekTo(
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
                            height: 0,
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                      Flexible(
                        flex: 1,
                        child: CustomSpeedButton(
                          ignoreButton: !clickable,
                          opacity: clickable ? 1.0 : 0.0,
                          controller: controller,
                          onSelected: (value) => controller.setPlaybackRate(value),
                          onOpened: () => showHideControl(
                            isPlaying: controller.value.isPlaying,
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
                        child: AnimatedOpacity(
                          opacity: clickable ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: IgnorePointer(
                            ignoring: !clickable,
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.fullscreen,
                                size: 25.sp,
                                color: whiteColor,
                              ),
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
    );
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
