import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomSegment extends StatelessWidget {
  final VoidCallback? onTapMovie;
  final VoidCallback? onTapTv;
  final int index;
  final double? widthTabBar;
  const CustomSegment({
    super.key,
    this.onTapMovie,
    this.onTapTv,
    required this.index,
    this.widthTabBar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingRight = const EdgeInsets.all(15).right.w;
        double paddingLeft = const EdgeInsets.all(15).left.w;
        double marginLeft = const EdgeInsets.all(5).left.w;
        double marginRight = const EdgeInsets.all(5).right.w;
        double width =
            (constraints.maxWidth - (paddingRight + paddingLeft + marginLeft + marginRight)) / 2;
        return Padding(
          padding: EdgeInsets.fromLTRB(paddingLeft.w, 15.h, paddingRight.w, 15.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  curve: Curves.decelerate,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(marginLeft, 5.h, marginRight, 5.h),
                    width: width,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(11.r),
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
              Container(
                width: widthTabBar,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: darkBlueColor,
                    width: 2.w,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapMovie,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              bottomLeft: Radius.circular(20.r),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Movies',
                            textScaler: const TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: index == 0 ? whiteColor : darkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapTv,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            'Tv Shows',
                            textScaler: const TextScaler.linear(1.1),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: index == 1 ? whiteColor : darkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
