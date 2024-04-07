import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSeekButton extends StatelessWidget {
  final VoidCallback? onTapButton;
  final String imagePath;
  final bool ignoreButton;
  final double opacity;
  const CustomSeekButton({
    super.key,
    this.onTapButton,
    required this.imagePath,
    required this.ignoreButton,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: ignoreButton,
        child: GestureDetector(
          onTap: onTapButton,
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.scaleDown,
            width: 17.w,
            height: 17.h,
          ),
        ),
      ),
    );
  }
}
