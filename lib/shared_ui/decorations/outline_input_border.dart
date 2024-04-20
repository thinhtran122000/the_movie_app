import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/shared_ui/colors/colors.dart';

OutlineInputBorder get transparentRadiusBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );

OutlineInputBorder get lightGreyRadiusBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(
        width: 1.sp,
        color: lightGreyColor,
      ),
    );

OutlineInputBorder get redRadiusBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(
        color: redColor,
        width: 2.sp,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    );

OutlineInputBorder get skyBlueRadiusInputBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(
        width: 2.sp,
        color: lightBlueColor,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    );
