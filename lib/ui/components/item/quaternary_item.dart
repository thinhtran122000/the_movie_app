import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class QuaternaryItem extends StatelessWidget {
  final String? imageUrl;
  final String? originalLanguage;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? voteAverage;
  final VoidCallback? onTapItem;
  const QuaternaryItem({
    super.key,
    this.imageUrl,
    this.originalLanguage,
    this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: RepaintBoundary(
        child: IntrinsicHeight(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 11.h, 6.w, 11.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title ?? '',
                          maxLines: 1,
                          softWrap: true,
                          textScaler: const TextScaler.linear(1),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        SizedBox(
                          height: 50.h,
                          child: Text(
                            overview ?? 'Coming soon',
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textScaler: const TextScaler.linear(1),
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 0, 6.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 16.sp,
                              ),
                              Flexible(
                                // flex: 5,
                                child: SizedBox(
                                  width: 100.w,
                                  child: Text(
                                    releaseDate ?? '',
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textScaler: const TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: indigoColor,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: yellowColor,
                                size: 17.sp,
                              ),
                              Text(
                                voteAverage ?? '',
                                textScaler: const TextScaler.linear(1),
                                style: TextStyle(
                                  color: yellowColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Container(
                                width: 23.w,
                                height: 19.h,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3).w,
                                decoration: BoxDecoration(
                                  color: gainsBoroColor,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Text(
                                  originalLanguage ?? '',
                                  textScaler: const TextScaler.linear(1),
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: imageUrl ?? '',
                  filterQuality: FilterQuality.high,
                  width: 100.w,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    ImagesPath.noImage.assetName,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
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
