import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';

class PrimaryItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final String? title;
  final String imageUrl;
  final Color? color;
  final List<double>? stops;
  const PrimaryItem({
    super.key,
    this.onTapItem,
    required this.title,
    this.color,
    this.stops,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: RepaintBoundary(
        child: Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                height: 150.h,
                width: 250.w,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        color ?? whiteColor,
                        BlendMode.color,
                      ),
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  ImagesPath.noImage.assetName,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Container(
                height: 150.h,
                width: 250.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  title ?? '',
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
