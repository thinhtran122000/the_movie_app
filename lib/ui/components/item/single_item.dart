import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class SingleItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final VoidCallback? onTapFavor;
  final String imageUrl;
  final List<Color> colors;
  final List<double> stops;
  final String? title;
  final int? season;
  final int? episode;
  final String? overview;
  final bool? favorite;
  final double averageLuminance;
  final String? posterPath;
  final String heroTag;
  const SingleItem({
    super.key,
    this.onTapItem,
    this.title,
    this.season,
    this.episode,
    this.overview,
    this.favorite,
    this.posterPath,
    required this.imageUrl,
    required this.stops,
    required this.colors,
    required this.averageLuminance,
    this.onTapFavor,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: RepaintBoundary(
        child: Container(
          height: 185.h,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: heroTag,
                child: CachedNetworkImage(
                  width: 115.w,
                  imageUrl: imageUrl,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) => SizedBox(
                    height: 172.h,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    ImagesPath.noImage.assetName,
                    width: 115.w,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                    gradient: colors.length >= 2 && colors.length == stops.length
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: stops,
                            colors: colors,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  '$title',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textScaler: const TextScaler.linear(1),
                                  style: TextStyle(
                                    height: 0,
                                    color: averageLuminance > 0.5 || posterPath == null
                                        ? blackColor
                                        : whiteColor,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: onTapFavor,
                                child: Icon(
                                  (favorite ?? false)
                                      ? Icons.favorite_sharp
                                      : Icons.favorite_outline_sharp,
                                  color: (favorite ?? false)
                                      ? yellowColor
                                      : averageLuminance > 0.5 || posterPath == null
                                          ? blackColor
                                          : whiteColor,
                                  size: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 25.w, 0),
                          child: Text(
                            'Season $season | Episode $episode',
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            textScaler: const TextScaler.linear(1),
                            style: TextStyle(
                              color: averageLuminance > 0.5 || posterPath == null
                                  ? blackColor
                                  : whiteColor,
                              fontSize: 14.sp,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                          child: Text(
                            '$overview',
                            maxLines: 4,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            textScaler: const TextScaler.linear(1),
                            style: TextStyle(
                              color: averageLuminance > 0.5 || posterPath == null
                                  ? blackColor
                                  : whiteColor,
                              fontSize: 12.sp,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              IconsPath.tvShowIcon.assetName,
                              colorFilter: ColorFilter.mode(
                                averageLuminance > 0.5 || posterPath == null
                                    ? blackColor
                                    : whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Watch now!',
                              textScaler: const TextScaler.linear(1),
                              style: TextStyle(
                                height: 0.h,
                                color: averageLuminance > 0.5 || posterPath == null
                                    ? blackColor
                                    : whiteColor,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
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
