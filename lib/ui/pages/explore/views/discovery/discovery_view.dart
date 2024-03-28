import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTabBar(
          height: 35.h,
          backgroundColor: whiteColor,
          tabs: [
            CustomTabBarItem(
              flex: 0,
              title: 'Browse',
              backgroundColor: lightGreyColor.withOpacity(0.2),
              textColor: darkBlueColor,
              dividerColor: darkBlueColor,
              padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
              onTapItem: () {},
            ),
            CustomTabBarItem(
              flex: 0,
              title: 'Streaming',
              backgroundColor: lightGreyColor.withOpacity(0.2),
              textColor: greyColor,
              dividerColor: Colors.transparent,
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
              onTapItem: () {},
            ),
            CustomTabBarItem(
              flex: 1,
              title: 'Coming soon',
              backgroundColor: lightGreyColor.withOpacity(0.2),
              textColor: greyColor,
              dividerColor: Colors.transparent,
              onTapItem: () {},
            ),
            CustomTabBarItem(
              flex: 0,
              title: 'In theaters',
              backgroundColor: lightGreyColor.withOpacity(0.2),
              textColor: greyColor,
              dividerColor: Colors.transparent,
              padding: EdgeInsets.fromLTRB(10.w, 0, 8.w, 0),
              onTapItem: () {},
            ),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: 0,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
