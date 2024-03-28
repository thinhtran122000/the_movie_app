import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomScrollButton extends StatelessWidget {
  final bool visible;
  final VoidCallback? onTap;
  final double? fallPosition;
  const CustomScrollButton({
    super.key,
    this.onTap,
    required this.visible,
    this.fallPosition,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: visible ? Alignment(0, fallPosition ?? 0) : Alignment(0, -1.5.h),
          child: Container(
            padding: const EdgeInsets.all(10).w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_upward,
              color: darkBlueColor,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
