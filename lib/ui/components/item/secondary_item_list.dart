import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/ui/components/components.dart';

class SecondaryItemList extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String? title;
  final String imageUrl;
  const SecondaryItemList({
    super.key,
    this.title,
    required this.imageUrl,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index == itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Column(
          children: [
            Container(
              width: 70.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: lightGreyColor,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: index == itemCount
                  ? ItemViewAll(
                      width: 35.w,
                      height: 35.h,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity.w,
                        height: double.infinity.h,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CustomIndicator(),
                        errorWidget: (context, url, error) => const CustomIndicator(),
                      ),
                    ),
            ),
            SizedBox(height: 7.h),
            SizedBox(
              width: 67.w,
              child: Text(
                title ?? '',
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
