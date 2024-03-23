import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class TertiaryItem extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final double? voteAverage;
  final bool? enableInfo;
  final bool? watchlist;
  final bool? favorite;
  final int itemCount;
  final int index;
  final String heroTag;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final VoidCallback? onTapBanner;
  final VoidCallback? onTapFavor;
  final VoidCallback? onTapInfo;

  const TertiaryItem({
    super.key,
    this.onTapItem,
    this.onTapViewAll,
    this.title,
    this.enableInfo,
    this.onTapBanner,
    this.watchlist,
    this.onTapFavor,
    this.onTapInfo,
    this.favorite,
    this.voteAverage,
    required this.heroTag,
    required this.imageUrl,
    required this.itemCount,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index >= itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Container(
          width: 150.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: index >= itemCount
                ? BorderRadius.circular(15.r)
                : BorderRadius.only(
                    bottomRight: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                  ),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: index >= itemCount
              ? ItemViewAll(
                  width: 50.w,
                  height: 50.h,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: heroTag,
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            filterQuality: FilterQuality.high,
                            width: double.infinity,
                            height: (enableInfo ?? false) ? 190.h : 210.h,
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
                        Positioned(
                          width: 50.w,
                          height: 45.h,
                          top: -2.h,
                          left: -8.3.w,
                          child: GestureDetector(
                            onTap: onTapBanner,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  IconsPath.watchListIcon.assetName,
                                  height: 60.h,
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                    (watchlist ?? false)
                                        ? yellowColor
                                        : blackColor.withOpacity(0.4),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Positioned(
                                  top: 9.h,
                                  child: Icon(
                                    (watchlist ?? false) ? Icons.check : Icons.add,
                                    color: whiteColor,
                                    size: 22.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          width: 30.w,
                          height: 30.h,
                          bottom: 2.h,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: onTapFavor,
                            child: Container(
                              decoration: BoxDecoration(
                                color: blackColor.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                (favorite ?? false)
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_outline_sharp,
                                color: (favorite ?? false) ? yellowColor : whiteColor,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: yellowColor,
                            size: 16.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '$voteAverage',
                            maxLines: 1,
                            softWrap: false,
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 14.sp,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        title ?? '',
                        maxLines: 1,
                        softWrap: false,
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 14.5.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    (enableInfo ?? false)
                        ? GestureDetector(
                            onTap: onTapInfo,
                            child: Padding(
                              padding: EdgeInsets.only(left: 120.w),
                              child: Icon(
                                Icons.info_outlined,
                                color: greyColor,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
        ),
      ),
    );
  }
}
