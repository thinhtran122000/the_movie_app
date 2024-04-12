import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final Widget? image;
  final Color? backgroundColor;
  final String? title;
  final String? content;
  final String? titleFirstChoice;
  final String? titleSecondChoice;
  final String? titleSingleChoice;
  final bool? canPopDialog;
  final bool? isLoading;
  final bool? isMultipleChoice;
  final bool? enabledTitle;
  final bool? enabledContent;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final TextStyle? singleChoiceStyle;
  final TextStyle? firstChoiceStyle;
  final TextStyle? secondChoiceStyle;
  final VoidCallback? onTapSingleChoice;
  final VoidCallback? onTapFirstChoice;
  final VoidCallback? onTapSecondChoice;
  const CustomDialog({
    super.key,
    this.image,
    this.backgroundColor,
    this.title,
    this.content,
    this.titleFirstChoice,
    this.titleSecondChoice,
    this.titleSingleChoice,
    this.canPopDialog,
    this.isLoading,
    this.isMultipleChoice,
    this.enabledTitle,
    this.enabledContent,
    this.titleStyle,
    this.contentStyle,
    this.singleChoiceStyle,
    this.firstChoiceStyle,
    this.secondChoiceStyle,
    this.onTapSingleChoice,
    this.onTapFirstChoice,
    this.onTapSecondChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      insetPadding: (isLoading ?? false)
          ? const EdgeInsets.symmetric(
              vertical: 140,
              horizontal: 140,
            )
          : const EdgeInsets.symmetric(
              vertical: 140,
              horizontal: 60,
            ),
      backgroundColor: backgroundColor,
      elevation: 0,
      child: PopScope(
        canPop: canPopDialog ?? true,
        child: (isLoading ?? false)
            ? AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: image,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        image ?? const SizedBox(),
                        // Lottie.asset(
                        //   AnimationsPath.pandaSleepAnimation.assetName,
                        //   repeat: true,
                        //   width: 120.w,
                        //   height: 120.h,
                        //   fit: BoxFit.fill,
                        //   filterQuality: FilterQuality.high,
                        // ),
                        (enabledTitle ?? true)
                            ? Text(
                                '$title',
                                style: titleStyle,
                                // style: TextStyle(
                                //   color: blackColor,
                                //   fontSize: 22.sp,
                                //   fontWeight: FontWeight.bold,
                                // ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 5.h),
                        (enabledContent ?? true)
                            ? Text(
                                '$content',
                                // 'Your session has been expired.\nPlease login again !',
                                // 'Sign out of TMDb',
                                textAlign: TextAlign.center,
                                style: contentStyle,
                                // style: TextStyle(
                                //   color: darkBlueColor,
                                //   fontSize: 14.sp,
                                //   fontWeight: FontWeight.bold,
                                //   height: 1.5,
                                // ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const Divider(height: 1),
                  (isMultipleChoice ?? false)
                      ? IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: CupertinoDialogAction(
                                  onPressed: onTapFirstChoice,
                                  child: Text(
                                    '$titleFirstChoice',
                                    style: firstChoiceStyle,
                                    // style: TextStyle(
                                    //   color: redColor,
                                    //   fontSize: 15.sp,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1),
                              Flexible(
                                child: CupertinoDialogAction(
                                  onPressed: onTapSecondChoice,
                                  child: Text(
                                    '$titleSecondChoice',
                                    style: secondChoiceStyle,
                                    // style: TextStyle(
                                    //   color: redColor,
                                    //   fontSize: 15.sp,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : CupertinoDialogAction(
                          onPressed: onTapSingleChoice,
                          child: Text(
                            '$titleSingleChoice',
                            style: singleChoiceStyle,
                            // TextStyle(
                            //   color: redColor,
                            //   fontSize: 15.sp,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
