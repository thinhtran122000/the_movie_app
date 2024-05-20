import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class ItemViewAll extends StatelessWidget {
  final double? sizeIcon;
  final String? title;
  const ItemViewAll({
    super.key,
    this.sizeIcon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          size: sizeIcon ?? 40.sp,
          Icons.arrow_circle_right_sharp,
          color: darkBlueColor,
        ),
        SizedBox(height: 5.h),
        Text(
          title ?? 'View all',
          textScaler: const TextScaler.linear(1),
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 2,
          style: TextStyle(
            color: darkBlueColor,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
