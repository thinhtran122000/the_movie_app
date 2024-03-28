// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:movie_app/shared_ui/shared_ui.dart';

// class CustomAppBarTitle extends StatelessWidget {
//   final String titleAppBar;
//   const CustomAppBarTitle({
//     super.key,
//     required this.titleAppBar,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
//           child: CircleAvatar(
//             backgroundImage: Image.asset(
//               ImagesPath.corgi.assetName,
//             ).image,
//           ),
//         ),
//         SizedBox(width: 15.w),
//         Text(
//           titleAppBar,
//           textScaleFactor: 1,
//           maxLines: 2,
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w400,
//             color: whiteColor,
//           ),
//         ),
//         const Spacer(),
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
//           child: Icon(
//             Icons.notifications_sharp,
//             color: whiteColor,
//             size: 30.sp,
//           ),
//         ),
//       ],
//     );
//   }
// }
