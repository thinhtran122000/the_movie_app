import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class SenaryItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final VoidCallback? onTapBanner;
  final VoidCallback? onTapFavor;
  final String imageUrl;
  final String? rank;
  final String? title;
  final double? voteAverage;
  final bool? watchlist;
  final bool? favorite;
  final String heroTag;

  const SenaryItem({
    super.key,
    this.onTapItem,
    this.onTapBanner,
    this.title,
    this.rank,
    this.voteAverage,
    this.watchlist,
    this.onTapFavor,
    this.favorite,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: RepaintBoundary(
        child: Container(
          width: 150.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
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
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: heroTag,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          filterQuality: FilterQuality.high,
                          width: double.infinity,
                          height: 190.h,
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: onTapBanner,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                IconsPath.watchListIcon.assetName,
                                alignment: Alignment.topLeft,
                                width: 50.w,
                                height: 45.h,
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                  (watchlist ?? false) ? yellowColor : blackColor.withOpacity(0.4),
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: onTapFavor,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                            width: 30.w,
                            height: 30.h,
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
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    rank ?? '',
                    maxLines: 1,
                    softWrap: false,
                    textScaler: const TextScaler.linear(1),
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        textScaler: const TextScaler.linear(1),
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 14.sp,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    title ?? '',
                    maxLines: 1,
                    softWrap: false,
                    textScaler: const TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: 14.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
