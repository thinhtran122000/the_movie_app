import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class CustomSwitchButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTapItem;
  const CustomSwitchButton({
    super.key,
    this.onTapItem,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        alignment: Alignment.center,
        width: 70.w,
        height: 20.h,
        decoration: BoxDecoration(
          border: Border.all(color: darkBlueColor, width: 2),
          borderRadius: BorderRadius.circular(15.r),
          color: darkBlueColor,
        ),
        child: Text(
          title ?? '',
          textScaler: const TextScaler.linear(1),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: whiteColor,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
