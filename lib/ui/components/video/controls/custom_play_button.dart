import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomPlayButton extends StatelessWidget {
  final YoutubePlayerController controller;
  final VoidCallback? onTapButton;
  final double opacity;
  final String videoId;
  final bool ignoreButton;
  const CustomPlayButton({
    super.key,
    required this.controller,
    required this.opacity,
    this.onTapButton,
    required this.videoId,
    required this.ignoreButton,
  });

  @override
  Widget build(BuildContext context) {
    return videoId.isEmpty
        ? const SizedBox()
        : controller.value.playerState == PlayerState.unknown
            ? Center(
                child: Lottie.asset(
                  AnimationsPath.loadingAnimation.assetName,
                  repeat: true,
                  addRepaintBoundary: true,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.scaleDown,
                  height: 50,
                  width: 80,
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.color(
                        const ['**'],
                        value: whiteColor,
                      ),
                    ],
                  ),
                ),
              )
            : Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 300),
                  child: IgnorePointer(
                    ignoring: ignoreButton,
                    child: GestureDetector(
                      onTap: onTapButton,
                      child: Icon(
                        controller.value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        size: 50.sp,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              );
  }
}
