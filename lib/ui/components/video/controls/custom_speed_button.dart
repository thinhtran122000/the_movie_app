import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomSpeedButton extends StatelessWidget {
  final YoutubePlayerController controller;
  final List<double> playbackRate;
  final Function(double)? onSelected;
  final VoidCallback? onOpened;
  final VoidCallback? onCanceled;
  final bool ignoreButton;
  final double opacity;
  const CustomSpeedButton({
    super.key,
    this.onSelected,
    this.onOpened,
    this.onCanceled,
    required this.controller,
    required this.ignoreButton,
    required this.opacity,
    this.playbackRate = const [
      PlaybackRate.quarter,
      PlaybackRate.half,
      PlaybackRate.threeQuarter,
      PlaybackRate.normal,
      PlaybackRate.oneAndAQuarter,
      PlaybackRate.oneAndAHalf,
      PlaybackRate.oneAndAThreeQuarter,
      PlaybackRate.twice,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: ignoreButton,
        child: PopupMenuButton<double>(
          color: blackColor.withOpacity(0.5),
          position: PopupMenuPosition.over,
          padding: EdgeInsets.zero,
          offset: Offset(0, -200.h),
          onSelected: onSelected,
          onCanceled: onCanceled,
          onOpened: onOpened,
          tooltip: 'Open playback speed',
          icon: SvgPicture.asset(
            IconsPath.playbackSpeedIcon.assetName,
            height: 20.h,
          ),
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  List<PopupMenuItem<double>> itemBuilder(BuildContext context) => playbackRate
      .map<PopupMenuItem<double>>(
        (e) => PopupMenuItem(
          onTap: () => onSelected?.call(e),
          height: 30.h,
          value: e,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.value.playbackRate == e ? Icons.done : null,
                color: controller.value.playbackRate == e ? yellowColor : whiteColor,
                size: 15.sp,
              ),
              SizedBox(width: 5.w),
              Text(
                e == PlaybackRate.normal ? 'Normal' : '$e',
                style: TextStyle(
                  color: controller.value.playbackRate == e ? yellowColor : whiteColor,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      )
      .toList();
}
