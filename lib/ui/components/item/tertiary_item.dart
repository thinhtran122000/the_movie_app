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
              ? const ItemViewAll()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: onTapBanner,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    (watchlist ?? false)
                                        ? IconsPath.addedWatchListIcon.assetName
                                        : IconsPath.addWatchListIcon.assetName,
                                    alignment: Alignment.topLeft,
                                    width: 50.w,
                                    height: 45.h,
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    top: 9.h,
                                    child: Icon(
                                      (watchlist ?? false) ? Icons.check : Icons.add,
                                      color: (watchlist ?? false) ? blackColor : whiteColor,
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
                    SizedBox(height: 7.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
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
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        '$title',
                        maxLines: 1,
                        softWrap: false,
                        textScaler: const TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 14.5.sp,
                          overflow: TextOverflow.ellipsis,
                          height: 0,
                        ),
                      ),
                    ),
                    (enableInfo ?? false)
                        ? GestureDetector(
                            onTap: onTapInfo,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(120.w, 10.h, 0, 10.h),
                              child: Icon(
                                Icons.info_outlined,
                                color: greyColor,
                              ),
                            ),
                          )
                        : SizedBox(height: 10.h),
                  ],
                ),
        ),
      ),
    );
  }
}
