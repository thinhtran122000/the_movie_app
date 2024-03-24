import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSeekButton extends StatelessWidget {
  final VoidCallback? onTapButton;
  final String imagePath;
  const CustomSeekButton({
    super.key,
    this.onTapButton,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapButton,
      child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.scaleDown,
        width: 17.w,
        height: 17.h,
      ),
    );
  }
}
