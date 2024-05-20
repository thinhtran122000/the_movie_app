import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';

class QuaternaryItem extends StatelessWidget {
  final String? imageUrl;
  final String? originalLanguage;
  final String? title;
  final String? releaseDate;
  final String? voteAverage;
  final bool? watchlist;
  final dynamic rated;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapBanner;
  final String heroTag;

  const QuaternaryItem({
    super.key,
    this.imageUrl,
    this.originalLanguage,
    this.title,
    this.releaseDate,
    this.voteAverage,
    this.onTapItem,
    this.watchlist,
    this.onTapBanner,
    required this.heroTag,
    this.rated,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Ink(
        height: 130.h,
        color: whiteColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: heroTag,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl ?? '',
                        filterQuality: FilterQuality.high,
                        width: 60.w,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CustomIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          ImagesPath.noImage.assetName,
                          filterQuality: FilterQuality.high,
                          width: 60.w,
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
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 5.h,
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
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        title ?? '',
                        maxLines: 2,
                        softWrap: true,
                        textScaler: const TextScaler.linear(1),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Flexible(
                      flex: 3,
                      child: Text(
                        'Release: ${releaseDate ?? 'Unknown'}',
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textScaler: const TextScaler.linear(1),
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Flexible(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Icon(
                              Icons.star,
                              color: yellowColor,
                              size: 16.sp,
                              applyTextScaling: true,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            child: Text(
                              voteAverage ?? '',
                              textScaler: const TextScaler.linear(1),
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 14.sp,
                                height: 1,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          (rated is Rated?)
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Icon(
                                        Icons.star,
                                        color: brightNavyBlue,
                                        size: 16.sp,
                                        applyTextScaling: true,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Flexible(
                                      child: Text(
                                        double.parse(
                                          (rated?.value ?? 0).toStringAsFixed(1),
                                        ).ceil().toString(),
                                        textScaler: const TextScaler.linear(1),
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 14.sp,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                  ],
                                )
                              : const SizedBox(),
                          Flexible(
                            flex: 3,
                            child: Text(
                              originalLanguage?.toUpperCase() ?? '',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textScaler: const TextScaler.linear(1),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: greyColor,
                                // height: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: SvgPicture.asset(
                    IconsPath.optionIcon.assetName,
                    width: 2.w,
                    height: 4.h,
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
