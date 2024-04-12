import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? appBarHeight;
  final Widget? leading;
  final Widget? customTitle;
  final String? title;
  final bool? centerTitle;
  final double? titleSpacing;
  final Widget? actions;
  final VoidCallback? onTapLeading;
  final VoidCallback? onTapAction;

  const CustomAppBar({
    super.key,
    this.customTitle,
    this.actions,
    this.leading,
    this.titleSpacing,
    this.centerTitle,
    this.onTapLeading,
    this.title,
    this.onTapAction,
    this.appBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight ?? 100.h,
      decoration: BoxDecoration(
        color: darkBlueColor,
      ),
      child: customTitle ??
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: leading == null ? 0 : 1,
                  child: GestureDetector(
                    onTap: onTapLeading,
                    child: leading ?? const SizedBox(),
                  ),
                ),
                leading == null ? const SizedBox() : SizedBox(width: 15.w),
                Expanded(
                  flex: 7,
                  child: Text(
                    '$title',
                    textAlign: centerTitle ?? false ? TextAlign.center : TextAlign.left,
                    textScaler: const TextScaler.linear(1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: whiteColor,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onTapAction,
                    child: actions ?? SizedBox(width: 30.w),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
