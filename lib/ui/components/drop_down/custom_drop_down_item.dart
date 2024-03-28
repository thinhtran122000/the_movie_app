import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final Color? colorSelected;
  final String title;
  final Color? colorTitle;
  const CustomDropDownItem({
    super.key,
    this.onTapItem,
    this.colorSelected,
    required this.title,
    this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: colorSelected,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          textScaler: const TextScaler.linear(1),
          style: TextStyle(
            color: colorTitle,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
