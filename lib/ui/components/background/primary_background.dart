import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class PrimaryBackground extends StatelessWidget {
  const PrimaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagesPath.background.assetName,
      height: 200.h,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
    );
  }
}
