import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVolumeButton extends StatelessWidget {
  final YoutubePlayerController controller;
  final VoidCallback? onTapButton;
  final IconData? icon;
  final double? size;
  final double? width;
  final bool enabledUnmute;
  final Color? colorButton;
  final bool ignoreButton;
  final double opacity;
  const CustomVolumeButton({
    super.key,
    this.onTapButton,
    this.icon,
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
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IgnorePointer(
            ignoring: ignoreButton,
            child: GestureDetector(
              onTap: onTapButton,
              child: AnimatedSize(
                alignment: Alignment.centerLeft,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOutSine,
                child: FractionallySizedBox(
                  child: Container(
                    width: width,
                    padding: EdgeInsets.fromLTRB(0.w, 0, 0.w, 0),
                    decoration: BoxDecoration(
                      color: colorButton,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Icon(
                            icon,
                            color: whiteColor,
                            size: size ?? 27.sp,
                          ),
                        ),
                        controller.value.position.inMilliseconds <= 5000 && enabledUnmute
                            ? Flexible(
                                flex: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Text(
                                    'TAP TO UNMUTE',
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
