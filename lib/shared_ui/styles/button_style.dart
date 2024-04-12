import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

ButtonStyle get optionPrimaryButtonStyle => ButtonStyle(
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

ButtonStyle get createAccountPrimaryButtonStyle => ButtonStyle(
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

ButtonStyle get createAccountSecondaryButtonStyle => ButtonStyle(
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

ButtonStyle get loginPrimaryButtonStyle => ButtonStyle(
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
