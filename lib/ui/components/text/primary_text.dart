import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class PrimaryText extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool? enableRightWidget;
  final Widget? rightWidget;
  final bool? visibleIcon;
  final double? paddingLeft;
  final double? paddingRight;

  final VoidCallback? onTapViewAll;

  const PrimaryText({
    super.key,
    this.icon,
    this.enableRightWidget,
    this.onTapViewAll,
    required this.title,
    this.rightWidget,
    this.visibleIcon,
    this.paddingLeft,
    this.paddingRight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft ?? 17.w, 0, paddingRight ?? 17.w, 0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 0,
              child: visibleIcon ?? false
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                      child: icon ?? const SizedBox(),
                    )
                  : const SizedBox(),
            ),
            Expanded(
              child: Text(
                title,
                textScaler: const TextScaler.linear(1),
                style: TextStyle(
                  height: 0,
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp,
                  color: blackColor,
                ),
              ),
            ),
            enableRightWidget ?? true
                ? rightWidget ??
                    GestureDetector(
                      onTap: onTapViewAll,
                      child: Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View all',
                              textScaler: const TextScaler.linear(1),
                              style: TextStyle(
                                height: 0,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: darkBlueColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              size: 10.sp,
                              color: darkBlueColor,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
