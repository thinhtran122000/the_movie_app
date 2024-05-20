import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isNested;
  final TextStyle? titleStyle;
  final double? appBarHeight;
  final Widget? leading;
  final Widget? customTitle;
  final String? title;
  final bool? centerTitle;
  final Widget? actions;
  final VoidCallback? onTapLeading;
  final VoidCallback? onTapAction;

  const CustomAppBar({
    super.key,
    this.customTitle,
    this.actions,
    this.leading,
    this.centerTitle,
    this.onTapLeading,
    this.title,
    this.onTapAction,
    this.appBarHeight,
    this.titleStyle,
    this.isNested,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight ?? 70.h,
      decoration: BoxDecoration(
        color: darkBlueColor,
      ),
      child: customTitle ??
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, (isNested ?? false) ? 5.h : 35.h, 10.w, 5.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onTapLeading,
                    child: leading ?? const SizedBox(),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    textScaler: const TextScaler.linear(1),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle,
                  ),
                ),
                // const SizedBox.shrink(),
                Flexible(
                  flex: 1,
                  child: actions == null
                      ? SizedBox(
                          width: 21.w,
                        )
                      : GestureDetector(
                          onTap: onTapAction,
                          child: actions,
                        ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 70.h);
}
