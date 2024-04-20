import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class CustomToast extends StatelessWidget {
  final bool visible;
  final double opacity;
  final String? statusMessage;
  final VoidCallback? onEndAnimation;
  const CustomToast({
    super.key,
    this.onEndAnimation,
    this.statusMessage,
    required this.visible,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      onEnd: onEndAnimation,
      child: Visibility(
        maintainState: true,
        maintainAnimation: true,
        visible: visible,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          alignment: Alignment.center,
          height: 50.h,
          color: yellowColor,
          child: Text(
            statusMessage ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
