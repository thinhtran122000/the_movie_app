import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVolumeButton extends StatelessWidget {
  final YoutubePlayerController controller;
  final VoidCallback? onTapButton;
  final Widget icon;
  final double? size;
  final double? width;
  final bool enabledUnmute;
  final Color? colorButton;
  final bool ignoreButton;
  final double opacity;
  const CustomVolumeButton({
    super.key,
    this.onTapButton,
    required this.icon,
    this.size,
    this.width,
    this.colorButton,
    required this.controller,
    required this.enabledUnmute,
    required this.ignoreButton,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: ignoreButton,
        child: GestureDetector(
          onTap: onTapButton,
          child: AnimatedSize(
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutSine,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: colorButton,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: icon,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0,
                        5.h,
                        controller.value.position.inMilliseconds <= 5000 && enabledUnmute ? 5.w : 0,
                        5.h),
                    child: Text(
                      controller.value.position.inMilliseconds <= 5000 && enabledUnmute
                          ? 'Tap to unmute'
                          : '',
                      textScaler: const TextScaler.linear(1),
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
