import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class CustomSegment extends StatelessWidget {
  final VoidCallback? onTapFirstItem;
  final VoidCallback? onTapSecondItem;
  final VoidCallback? onTapThirdItem;

  final int index;
  final double? widthSegment;
  final List<String> items;
  const CustomSegment({
    super.key,
    this.onTapFirstItem,
    this.onTapSecondItem,
    this.onTapThirdItem,
    required this.index,
    this.widthSegment,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingRight = const EdgeInsets.all(10).right.w;
        double paddingLeft = const EdgeInsets.all(10).left.w;
        double marginLeft = const EdgeInsets.all(5).left.w;
        double marginRight = const EdgeInsets.all(5).right.w;
        double width =
            (constraints.maxWidth - (paddingRight + paddingLeft + marginLeft + marginRight)) /
                items.length;
        return Padding(
          padding: EdgeInsets.fromLTRB(paddingLeft.w, 10.h, paddingRight.w, 10.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: widthSegment,
                height: 40.h,
                decoration: BoxDecoration(
                  color: gainsBoroColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: darkBlueColor,
                    width: 2.w,
                  ),
                ),
              ),
              Positioned(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  curve: Curves.decelerate,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(marginLeft, 5.h, marginRight, 5.h),
                    width: width,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                      color: darkBlueColor,
                      boxShadow: [
                        BoxShadow(
                          color: greyColor,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: items
                    .map<Widget>(
                      (e) => Expanded(
                        child: GestureDetector(
                          onTap: items.indexOf(e) == 0
                              ? onTapFirstItem
                              : items.indexOf(e) == 1
                                  ? onTapSecondItem
                                  : onTapThirdItem,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                bottomLeft: Radius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              e,
                              textScaler: const TextScaler.linear(1),
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: index == items.indexOf(e) ? whiteColor : darkBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                // children: [
                // Expanded(
                //   child: GestureDetector(
                //     onTap: onTapMovie,
                //     child: Container(
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(20.r),
                //           bottomLeft: Radius.circular(20.r),
                //         ),
                //       ),
                //       child: Text(
                //         'Movies',
                //         textScaler: const TextScaler.linear(1),
                //         style: TextStyle(
                //           fontSize: 15.sp,
                //           color: index == 0 ? whiteColor : darkBlueColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                //   Expanded(
                //     child: GestureDetector(
                //       onTap: onTapTv,
                //       child: Container(
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //             topRight: Radius.circular(20.r),
                //             bottomRight: Radius.circular(20.r),
                //           ),
                //         ),
                //         child: Text(
                //           'TV Shows',
                //           textScaler: const TextScaler.linear(1),
                //           style: TextStyle(
                //             fontSize: 15.sp,
                //             color: index == 1 ? whiteColor : darkBlueColor,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                //   Expanded(
                //     child: GestureDetector(
                //       onTap: onTapTv,
                //       child: Container(
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //             topRight: Radius.circular(20.r),
                //             bottomRight: Radius.circular(20.r),
                //           ),
                //         ),
                //         child: Text(
                //           'TV Shows',
                //           textScaler: const TextScaler.linear(1),
                //           style: TextStyle(
                //             fontSize: 15.sp,
                //             color: index == 1 ? whiteColor : darkBlueColor,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
              ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
