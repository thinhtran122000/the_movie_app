import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/paths/images_path.dart';
import 'package:movie_app/ui/components/components.dart';

class SliderItem extends StatelessWidget {
  final String? imageUrlPoster;
  final VoidCallback? onTap;
  final String? imageUrlBackdrop;
  final String? title;
  final double? voteAverage;
  final bool isBackdrop;
  const SliderItem({
    super.key,
    this.onTap,
    this.title,
    this.voteAverage,
    required this.isBackdrop,
    this.imageUrlPoster,
    this.imageUrlBackdrop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: isBackdrop
            ? CachedNetworkImage(
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
              )
            : Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.5.w),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.r),
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
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.r),
                      ),
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
                                heightBackground: 53.h,
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
                                        textScaleFactor: 1,
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
                                          textScaleFactor: 1,
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
                                heightBackground: 88.h,
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
                                  textScaleFactor: 1,
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
    );
  }
}
