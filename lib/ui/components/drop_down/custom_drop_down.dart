import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';

class CustomDropDown extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData? icon;
  const CustomDropDown({
    super.key,
    this.onTap,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 30.h,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: darkBlueColor,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Text(
                      AppUtils().getSortTitle(title),
                      textScaler: const TextScaler.linear(1),
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox();
}
