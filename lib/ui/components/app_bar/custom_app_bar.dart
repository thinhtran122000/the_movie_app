import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? customTitle;
  final String? title;
  final bool? centerTitle;
  final double? titleSpacing;
  final Widget? actions;
  final double? widthSpace;
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
    this.widthSpace,
    this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: darkBlueColor,
      ),
      child: customTitle ??
          Padding(
            padding: EdgeInsets.fromLTRB(15.w, 20.h, 10.w, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   backgroundImage: Image.asset(
                //     ImagesPath.corgi.assetName,
                //   ).image,
                // ),
                GestureDetector(
                  onTap: onTapLeading,
                  child: leading ?? SizedBox(width: centerTitle ?? false ? 30.w : 0),
                ),
                SizedBox(width: widthSpace),
                Expanded(
                  child: Container(
                    alignment: centerTitle ?? false ? Alignment.center : Alignment.centerLeft,
                    child: Text(
                      '$title',
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
                ),
                // const Spacer(),
                GestureDetector(
                  onTap: onTapAction,
                  child: actions ?? SizedBox(width: 30.w),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
                //   child: Icon(
                //     Icons.notifications_sharp,
                //     color: whiteColor,
                //     size: 30.sp,
                //   ),
                // ),
              ],
            ),
            //  AppBar(
            //   elevation: 0,
            // title: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     SizedBox(height: 30.h),
            //     title ?? const SizedBox(),
            //   ],
            // ),
            //   automaticallyImplyLeading: false,
            //   centerTitle: centerTitle,
            //   titleSpacing: titleSpacing,
            //   leadingWidth: leadingWidth,
            //   backgroundColor: darkBlueColor,
            //   flexibleSpace: Container(),
            //   actions: actions,
            //   leading: GestureDetector(
            //     onTap: onTapLeading,
            //     child: leading,
            //   ),
            // ),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
