import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBarItem extends StatelessWidget {
  final int flex;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? dividerColor;

  final String? title;
  final VoidCallback? onTapItem;
  const CustomTabBarItem({
    super.key,
    this.flex = 0,
    this.title,
    this.backgroundColor,
    this.padding,
    this.textColor,
    this.dividerColor,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: onTapItem,
        child: flex == 0
            ? IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: padding,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                        ),
                        child: Text(
                          '$title',
                          textScaler: const TextScaler.linear(1),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: dividerColor,
                      thickness: 2,
                      height: 0,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: padding,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                      ),
                      child: Text(
                        '$title',
                        textScaler: const TextScaler.linear(1),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: dividerColor,
                    thickness: 2,
                    height: 0,
                    indent: 0,
                    endIndent: 0,
                  ),
                ],
              ),
      ),
    );
  }
}
