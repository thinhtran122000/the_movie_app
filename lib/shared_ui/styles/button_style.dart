import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/shared_ui/colors/colors.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

ButtonStyle get optionAuthPrimaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: MaterialStateProperty.all<double>(0.1),
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.4)),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: whiteColor,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get registerPrimaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(lightGreyColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: darkBlueColor,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get registerSecondaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(lightGreyColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: lightGreyColor,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get loginPrimaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: MaterialStateProperty.all<double>(1),
      backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(lightGreyColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: darkBlueColor,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get optionSettingPrimaryStyle => ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0.1),
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      ),
      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(),
      ),
    );

ButtonStyle get logoutPrimaryStyle => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(lightGreyColor),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 40.w,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: whiteColor,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get sortPrimaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(lightGreyColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: darkBlueColor,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get addWatchlistPrimaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(yellowColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(lightGreyColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: noColor,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get addWatchlistSecondaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
      overlayColor: MaterialStateProperty.all<Color>(lightGreyColor.withOpacity(0.95)),
      shadowColor: MaterialStateProperty.all<Color>(whiteColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: greyColor,
            strokeAlign: BorderSide.strokeAlignInside,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get ratingPrimaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(yellowColor),
      overlayColor: MaterialStateProperty.all<Color>(blackColor.withOpacity(0.85)),
      shadowColor: MaterialStateProperty.all<Color>(noColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: yellowColor,
            strokeAlign: BorderSide.strokeAlignInside,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );

ButtonStyle get ratingSecondaryStyle => ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: MaterialStateProperty.all<Color>(blackColor.withOpacity(0.4)),
      overlayColor: MaterialStateProperty.all<Color>(blackColor.withOpacity(0.4)),
      shadowColor: MaterialStateProperty.all<Color>(noColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: noColor,
            strokeAlign: BorderSide.strokeAlignInside,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );
