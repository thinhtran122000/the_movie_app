import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/ui.dart';

class DenariItem extends StatelessWidget {
  final List<dynamic> multipleList;
  final List<String> listTitle;
  final int index;
  const DenariItem({
    super.key,
    this.multipleList = const [1, 2, 3, 4, 5, 6],
    required this.index,
    this.listTitle = const [],
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5.r),
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
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) => Stack(
                      alignment: Alignment.center,
                      children: multipleList
                          .map<Widget>(
                            (e) => Align(
                              alignment: multipleList.indexOf(e) == 0
                                  ? Alignment.centerRight
                                  : multipleList.indexOf(e) == 1
                                      ? Alignment.center
                                      : Alignment.centerLeft,
                              child: RepaintBoundary(
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: whiteColor,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      width: 0.5.w,
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500/3vxvsmYLTf4jnr163SUlBIw51ee.jpg',
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                    color: multipleList.indexOf(e) == 0
                                        ? whiteColor.withOpacity(0.5)
                                        : multipleList.indexOf(e) == 1
                                            ? whiteColor.withOpacity(0.25)
                                            : null,
                                    colorBlendMode: BlendMode.srcOver,
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
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  listTitle.isNotEmpty ? listTitle[index] : '',
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
            // SizedBox(height: 15.h),
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