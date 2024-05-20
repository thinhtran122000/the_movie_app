import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/shared_ui/paths/images_path.dart';
import 'package:tmdb/ui/components/components.dart';

class SliderItem extends StatelessWidget {
  final String? imageUrlPoster;
  final VoidCallback? onTap;
  final String? imageUrlBackdrop;
  final String? title;
  final double? voteAverage;
  final bool isBackdrop;
  final String heroTag;
  const SliderItem({
    super.key,
    this.onTap,
    this.title,
    this.voteAverage,
    required this.isBackdrop,
    this.imageUrlPoster,
    this.imageUrlBackdrop,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: noColor,
      child: InkWell(
        onTap: onTap,
        child: RepaintBoundary(
          child: isBackdrop
              ? Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: imageUrlBackdrop ?? '',
                    width: double.infinity,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      ImagesPath.noImage.assetName,
                      width: double.infinity,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.5.w),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Hero(
                        tag: heroTag,
                        child: CachedNetworkImage(
                          imageUrl: imageUrlPoster ?? '',
                          width: double.infinity,
                          height: double.infinity,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CustomIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                            ImagesPath.noImage.assetName,
                            width: double.infinity,
                            height: double.infinity,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(18.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(
                              children: [
                                BlurBackground(
                                  height: 53.h,
                                  width: 90.w,
                                  radiusCorner: 15.r,
                                ),
                                Container(
                                  width: 90.w,
                                  height: 53.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: whiteColor.withOpacity(0.4),
                                      strokeAlign: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: const Color(0xffDADADA).withOpacity(0.3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 18.w),
                                        child: Text(
                                          'IMDb',
                                          textScaler: const TextScaler.linear(1),
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: yellowColor,
                                            size: 25.sp,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            '$voteAverage',
                                            textScaler: const TextScaler.linear(1),
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                BlurBackground(
                                  height: 88.h,
                                  radiusCorner: 20.r,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 88.h,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      strokeAlign: 1,
                                      color: whiteColor.withOpacity(0.4),
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: const Color(0xffDADADA).withOpacity(0.3),
                                  ),
                                  child: Text(
                                    title ?? '',
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    textScaler: const TextScaler.linear(1),
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
