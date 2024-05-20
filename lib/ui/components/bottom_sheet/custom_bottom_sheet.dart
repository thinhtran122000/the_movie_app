import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class CustomBottomSheet extends StatelessWidget {
  final String? title;
  final String? titleConfirm;
  final String? titleCancel;
  final VoidCallback? onPressConfirm;
  final VoidCallback? onPressCancel;

  const CustomBottomSheet({
    super.key,
    this.title,
    this.titleConfirm,
    this.titleCancel,
    this.onPressConfirm,
    this.onPressCancel,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        title ?? '',
        textScaler: const TextScaler.linear(1),
        style: TextStyle(
          fontSize: 14.sp,
          color: greyColor,
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: false,
          onPressed: onPressConfirm ?? () {},
          child: Text(
            titleConfirm ?? '',
            textScaler: const TextScaler.linear(1),
            style: TextStyle(
              color: Colors.red,
              fontSize: 18.sp,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: onPressCancel ?? () {},
        child: Text(
          titleCancel ?? '',
          textScaler: const TextScaler.linear(1),
          style: TextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
