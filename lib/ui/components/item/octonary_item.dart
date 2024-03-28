import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class OctonaryItem extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final List<Color>? colors;
  final List<double>? stops;
  final int index;
  final int itemCount;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;

  const OctonaryItem({
    super.key,
    this.onTapItem,
    this.colors,
    this.stops,
    required this.title,
    required this.imageUrl,
    required this.index,
    required this.itemCount,
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index >= itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: IntrinsicWidth(
          child: index >= itemCount
              ? Container(
                  height: 200,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ItemViewAll(
                    width: 55.w,
                    height: 55.w,
                    sizeIcon: 50.sp,
                    title: 'More foundations',
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 110.h,
                      width: 157.w,
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: lightGreyColor,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
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
                    SizedBox(height: 7.h),
                    SizedBox(
                      width: 140.w,
                      child: Text(
                        title ?? '',
                        textScaler: const TextScaler.linear(1),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 14.sp,
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
