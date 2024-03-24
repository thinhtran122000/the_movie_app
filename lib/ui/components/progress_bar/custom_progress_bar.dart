import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomProgressBar extends StatelessWidget {
  final Function(PointerUpEvent)? onTap;
  final Function(PointerMoveEvent)? onSeek;
  final YoutubePlayerController controller;
  const CustomProgressBar({
    super.key,
    this.onTap,
    this.onSeek,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onTap,
      onPointerMove: onSeek,
      child: SizedBox(
        width: 310.w,
        child: ProgressBar(
          controller: controller,
          colors: ProgressBarColors(
            playedColor: whiteColor,
            handleColor: whiteColor,
            backgroundColor: whiteColor.withOpacity(0.2),
            bufferedColor: greyColor,
          ),
        ),
      ),
    );
  }
}
