import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class SecondaryText extends StatelessWidget {
  final String title;
  final Widget? icon;
  final VoidCallback? onTapViewAll;
  const SecondaryText({
    super.key,
    this.icon,
    this.onTapViewAll,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17.w, 0, 20.w, 0),
          child: Text(
            title,
            textScaler: const TextScaler.linear(1),
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: greyColor,
            ),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onTapViewAll,
              child: Text(
                'View all',
                textScaler: const TextScaler.linear(1),
                style: TextStyle(
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: greyColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 17.w, 0),
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 10.sp,
                  color: greyColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
