import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomVideoButton extends StatelessWidget {
  final VoidCallback? onTapButton;
  final IconData? icon;
  final double? size;
  const CustomVideoButton({
    super.key,
    this.onTapButton,
    this.icon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapButton,
      child: Icon(
        icon,
        color: whiteColor,
        size: size ?? 20.sp,
      ),
    );
  }
}
