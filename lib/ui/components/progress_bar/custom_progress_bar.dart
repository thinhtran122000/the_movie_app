import 'package:flutter/material.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomProgressBar extends StatelessWidget {
  final Function(PointerUpEvent)? onTap;
  final Function(PointerMoveEvent)? onSeek;
  final YoutubePlayerController controller;
  final bool ignoreButton;
  final double opacity;

  const CustomProgressBar({
    super.key,
    this.onTap,
    this.onSeek,
    required this.controller,
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
        child: Listener(
          onPointerUp: onTap,
          onPointerMove: onSeek,
          child: SizedBox(
            width: double.infinity,
            child: ProgressBar(
              controller: controller,
              colors: ProgressBarColors(
                playedColor: yellowColor,
                handleColor: yellowColor,
                backgroundColor: whiteColor.withOpacity(0.2),
                bufferedColor: greyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
