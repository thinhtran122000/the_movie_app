import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

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
          height: 172.h,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.r),
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
                      topRight: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 0, 5.w, 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 160.w,
                              child: Text(
                                title ?? '',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: averageLuminance > 0.5 || posterPath == null
                                      ? blackColor
                                      : whiteColor,
                                  fontSize: 20.sp,
                                ),
                              ),
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
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 0, 25.w, 0),
                        child: Text(
                          'Season $season | Episode $episode',
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: averageLuminance > 0.5 || posterPath == null
                                ? blackColor
                                : whiteColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 11.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 0, 25.w, 0),
                        child: Text(
                          overview ?? '',
                          maxLines: 4,
                          softWrap: false,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            color: averageLuminance > 0.5 || posterPath == null
                                ? blackColor
                                : whiteColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              textScaleFactor: 1,
                              style: TextStyle(
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
