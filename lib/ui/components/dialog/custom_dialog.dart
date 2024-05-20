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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        image ?? const SizedBox(),
                        (enabledTitle ?? true)
                            ? Flexible(
                                child: Text(
                                  '$title',
                                  textScaler: const TextScaler.linear(1),
                                  style: titleStyle,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : const SizedBox(),
                        // SizedBox(height: 5.h),
                        (enabledContent ?? true)
                            ? Flexible(
                                child: Text(
                                  '$content',
                                  textScaler: const TextScaler.linear(1),
                                  textAlign: TextAlign.center,
                                  style: contentStyle,
                                ),
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
                                    textScaler: const TextScaler.linear(1),
                                    style: firstChoiceStyle,
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1),
                              Flexible(
                                child: CupertinoDialogAction(
                                  onPressed: onTapSecondChoice,
                                  child: Text(
                                    '$titleSecondChoice',
                                    textScaler: const TextScaler.linear(1),
                                    style: secondChoiceStyle,
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
                            textScaler: const TextScaler.linear(1),
                            style: singleChoiceStyle,
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
