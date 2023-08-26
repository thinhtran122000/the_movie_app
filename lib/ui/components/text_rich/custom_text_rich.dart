import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextRich extends StatelessWidget {
  final String? primaryText;
  final String? secondaryText;
  final IconData icon;
  final Color? color;
  const CustomTextRich({
    super.key,
    this.primaryText,
    this.secondaryText,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: primaryText),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
              ),
              TextSpan(text: secondaryText),
            ],
          ),
          textScaleFactor: 1.1,
        ),
      ),
    );
  }
}
