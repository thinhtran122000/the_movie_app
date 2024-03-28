import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class DiscoveryView extends StatelessWidget {
  final String query;
  const DiscoveryView({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTabBar(
          height: 35.h,
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
        // SizedBox(
        //   height: 35.h,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        // Flexible(
        //   flex: 0,
        //   child: IntrinsicWidth(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Expanded(
        //           child: Container(
        //             alignment: Alignment.center,
        //             padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
        //             decoration: BoxDecoration(color: lightGreyColor.withOpacity(0.2)),
        //             child: Text(
        //               'Browse',
        //               textScaler: const TextScaler.linear(1),
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 color: darkBlueColor,
        //                 fontSize: 15.sp,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Divider(
        //           color: darkBlueColor,
        //           thickness: 2,
        //           height: 0,
        //           indent: 0,
        //           endIndent: 0,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        //       Flexible(
        //         flex: 0,
        //         child: IntrinsicWidth(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Expanded(
        //                 child: Container(
        //                   alignment: Alignment.center,
        //                   decoration: BoxDecoration(color: lightGreyColor.withOpacity(0.2)),
        //                   padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
        //                   child: Text(
        //                     'Streaming',
        //                     textScaler: const TextScaler.linear(1),
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       color: greyColor,
        //                       fontSize: 15.sp,
        //                       fontWeight: FontWeight.w500,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               const Divider(
        //                 color: Colors.transparent,
        //                 thickness: 2,
        //                 height: 0,
        //                 indent: 0,
        //                 endIndent: 0,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        // Flexible(
        //   flex: 1,
        //   child: Column(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           alignment: Alignment.center,
        //           decoration: BoxDecoration(color: lightGreyColor.withOpacity(0.2)),
        //           child: Text(
        //             'Coming soon',
        //             textScaler: const TextScaler.linear(1),
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: greyColor,
        //               fontSize: 15.sp,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //         ),
        //       ),
        //       const Divider(
        //         color: Colors.transparent,
        //         thickness: 2,
        //         height: 0,
        //         indent: 0,
        //         endIndent: 0,
        //       ),
        //     ],
        //   ),
        // ),
        //       Flexible(
        //         flex: 0,
        //         fit: FlexFit.tight,
        //         child: IntrinsicWidth(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Expanded(
        //                 child: Container(
        //                   alignment: Alignment.center,
        //                   decoration: BoxDecoration(color: lightGreyColor.withOpacity(0.2)),
        //                   padding: EdgeInsets.fromLTRB(10.w, 0, 8.w, 0),
        //                   child: Text(
        //                     'in theaters',
        //                     textScaler: const TextScaler.linear(1),
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       color: greyColor,
        //                       fontSize: 15.sp,
        //                       fontWeight: FontWeight.w500,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               const Divider(
        //                 color: Colors.transparent,
        //                 thickness: 2,
        //                 height: 0,
        //                 indent: 0,
        //                 endIndent: 0,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
                child: Text(query),
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
