import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class DenariItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final List<MultipleMedia> multipleList;
  final String? title;

  const DenariItem({
    super.key,
    this.title,
    this.multipleList = const [],
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.6),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 2,
                  child: RepaintBoundary(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) => Stack(
                          alignment: Alignment.center,
                          children: multipleList
                              .map<Widget>(
                                (e) => Align(
                                  alignment: multipleList.length == 1
                                      ? Alignment.center
                                      : multipleList.length == 2
                                          ? multipleList.indexOf(e) == 1
                                              ? const Alignment(0.4, 0)
                                              : const Alignment(-0.4, 0)
                                          : multipleList.indexOf(e) == 2
                                              ? Alignment.centerRight
                                              : multipleList.indexOf(e) == 1
                                                  ? Alignment.center
                                                  : Alignment.centerLeft,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        width: 0.5.w,
                                        color: whiteColor.withOpacity(0.5),
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: e.posterPath != null
                                          ? '${AppConstants.kImagePathPoster}${e.posterPath}'
                                          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                      color: multipleList.indexOf(e) == 2
                                          ? whiteColor.withOpacity(0.7)
                                          : multipleList.indexOf(e) == 1
                                              ? whiteColor.withOpacity(0.3)
                                              : null,
                                      colorBlendMode: BlendMode.srcOver,
                                      width: (constraints.maxWidth / 2.5),
                                      height: constraints.maxWidth,
                                      progressIndicatorBuilder: (context, url, prgress) =>
                                          const CustomIndicator(),
                                      errorWidget: (context, url, error) => Image.asset(
                                        ImagesPath.noImage.assetName,
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                              .reversed
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$title',
                      textScaler: const TextScaler.linear(1),
                      style: TextStyle(
                        height: 1.h,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: whiteColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.r),
                onTap: onTapItem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


   // multipleList.isEmpty
                  //                     ? CachedNetworkImage(
                  //                         imageUrl: 'https://image.tmdb.org/t/p/w500/3vxvsmYLTf4jnr163SUlBIw51ee.jpg',
                  //                         fit: BoxFit.cover,
                  //                         width: double.infinity,
                  //                         filterQuality: FilterQuality.high,
                  //                         progressIndicatorBuilder: (context, url, prgress) =>
                  //                             const CustomIndicator(),
                  //                         errorWidget: (context, url, error) => Image.asset(
                  //                           ImagesPath.noImage.assetName,
                  //                           filterQuality: FilterQuality.high,
                  //                           fit: BoxFit.fill,
                  //                         ),
                  //                       )
                  //                     :