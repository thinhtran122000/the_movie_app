import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/ui.dart';
import 'package:movie_app/utils/utils.dart';

class DenariItem extends StatelessWidget {
  final List<MultipleMedia> multipleList;
  final String? title;

  const DenariItem({
    super.key,
    this.title,
    this.multipleList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.6),
              blurRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
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
                    border: Border.all(
                      color: greyColor.withOpacity(0.5),
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 0.25.w,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) => Stack(
                      alignment: Alignment.center,
                      children:
                          //  multipleList
                          //     .take(3)
                          //     .map<Widget>(
                          //       (e) => Align(
                          //         alignment: multipleList.indexOf(e) == 0
                          //             ? Alignment.centerRight
                          //             : multipleList.indexOf(e) == 1
                          //                 ? Alignment.center
                          //                 : Alignment.centerLeft,
                          //         child: Container(
                          //           clipBehavior: Clip.antiAlias,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5.r),
                          //             border: Border.all(
                          //               width: 0.5.w,
                          //               color: whiteColor.withOpacity(0.5),
                          //               strokeAlign: BorderSide.strokeAlignOutside,
                          //             ),
                          //           ),
                          //           child: CachedNetworkImage(
                          //             imageUrl: e.posterPath != null
                          //                 ? '${AppConstants.kImagePathPoster}${e.posterPath}'
                          //                 : '',
                          //             fit: BoxFit.fill,
                          //             filterQuality: FilterQuality.high,
                          //             color: multipleList.indexOf(e) == 0
                          //                 ? whiteColor.withOpacity(0.6)
                          //                 : multipleList.indexOf(e) == 1
                          //                     ? whiteColor.withOpacity(0.3)
                          //                     : null,
                          //             colorBlendMode: BlendMode.srcOver,
                          //             width: 60.w,
                          //             progressIndicatorBuilder: (context, url, prgress) =>
                          //                 const CustomIndicator(),
                          //             errorWidget: (context, url, error) => Image.asset(
                          //               ImagesPath.noImage.assetName,
                          //               filterQuality: FilterQuality.high,
                          //               fit: BoxFit.fill,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //     .toList(),
                          [
                        Align(
                          alignment: Alignment.centerRight,
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
                              imageUrl: multipleList[1].posterPath != null
                                  ? '${AppConstants.kImagePathPoster}${multipleList[0].posterPath}'
                                  : '',
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                              color: whiteColor.withOpacity(0.6),
                              colorBlendMode: BlendMode.srcOver,
                              width: 60.w,
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
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                width: 0.3.w,
                                color: whiteColor.withOpacity(0.5),
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: multipleList[1].posterPath != null
                                  ? '${AppConstants.kImagePathPoster}${multipleList[1].posterPath}'
                                  : '',
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                              color: whiteColor.withOpacity(0.3),
                              colorBlendMode: BlendMode.srcOver,
                              width: 60.w,
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: whiteColor.withOpacity(0.5),
                                strokeAlign: BorderSide.strokeAlignOutside,
                                width: 0.3.w,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: multipleList[1].posterPath != null
                                  ? '${AppConstants.kImagePathPoster}${multipleList[2].posterPath}'
                                  : '',
                              fit: BoxFit.fill,
                              color: null,
                              colorBlendMode: BlendMode.srcOver,
                              filterQuality: FilterQuality.high,
                              width: 60.w,
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
                      ],
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
                    fontWeight: FontWeight.w500,
                    color: blackColor,
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