import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';

class SecondaryItem extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String? title;
  final String imageUrl;
  final String heroTag;
  final String errorImageUrl;
  const SecondaryItem({
    super.key,
    this.title,
    required this.imageUrl,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
    required this.heroTag,
    required this.errorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index >= itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Container(
                width: 90.w,
                height: 130.h,
                clipBehavior: Clip.antiAlias,
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
                child: index >= itemCount
                    ? ItemViewAll(
                        sizeIcon: 40.sp,
                      )
                    : Hero(
                        tag: heroTag,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CustomIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                            errorImageUrl,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: SizedBox(
                width: 70.w,
                child: Text(
                  index >= itemCount ? '' : '$title',
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
