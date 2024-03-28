import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomTabBar extends StatelessWidget {
  final double? height;
  final List<Widget> tabs;
  const CustomTabBar({
    super.key,
    this.height,
    this.tabs = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      // height: 35.h,
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: tabs,
        //  [
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
        // Flexible(
        //   flex: 0,
        //   child: IntrinsicWidth(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Expanded(
        //           child: Container(
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(color: lightGreyColor.withOpacity(0.2)),
        //             padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
        //             child: Text(
        //               'Streaming',
        //               textScaler: const TextScaler.linear(1),
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 color: greyColor,
        //                 fontSize: 15.sp,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         ),
        //         const Divider(
        //           color: Colors.transparent,
        //           thickness: 2,
        //           height: 0,
        //           indent: 0,
        //           endIndent: 0,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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
        // Flexible(
        //   flex: 0,
        //   fit: FlexFit.tight,
        //   child: IntrinsicWidth(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Expanded(
        //           child: Container(
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(color: lightGreyColor.withOpacity(0.2)),
        //             padding: EdgeInsets.fromLTRB(10.w, 0, 8.w, 0),
        //             child: Text(
        //               'in theaters',
        //               textScaler: const TextScaler.linear(1),
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 color: greyColor,
        //                 fontSize: 15.sp,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         ),
        //         const Divider(
        //           color: Colors.transparent,
        //           thickness: 2,
        //           height: 0,
        //           indent: 0,
        //           endIndent: 0,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // ],
      ),
    );
  }
}
