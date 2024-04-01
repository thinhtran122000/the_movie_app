import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: Container(
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.h),
            Flexible(
              flex: 1,
              child: PrimaryText(
                paddingLeft: 15.w,
                paddingRight: 15.w,
                title: 'Movie',
                visibleIcon: true,
                enableRightWidget: false,
                onTapViewAll: () {},
                icon: Icon(
                  Icons.local_movies_rounded,
                  color: yellowColor,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child:
                  // MasonryGridView.count(
                  //   padding: EdgeInsets.fromLTRB(13.w, 17.h, 13.w, 17.h),
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 10,
                  //   crossAxisSpacing: 10,
                  //   itemCount: 10,
                  //   itemBuilder: itemBuilder,
                  // ),
                  MasonryGridView.count(
                padding: EdgeInsets.fromLTRB(13.w, 17.h, 13.w, 17.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: 6,
                itemBuilder: itemBuilder,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return DenariItem(
      index: index,
      listTitle: const [
        'Movie showtimes',
        'Popular movies',
        'Trending movies',
        'Top 250 movies',
        'Coming soon',
        'Most popular by genre',
        'Movie news',
      ],
    );
    // Container(
    //   decoration: BoxDecoration(
    //     color: whiteColor,
    //     boxShadow: [
    //       BoxShadow(
    //         color: greyColor.withOpacity(0.6),
    //         blurRadius: 1,
    //       ),
    //     ],
    //   ),
    //   padding: const EdgeInsets.all(6),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Flexible(
    //         flex: 2,
    //         child: Container(
    //           clipBehavior: Clip.hardEdge,
    //           height: 80.h,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(5),
    //           ),
    //           child: LayoutBuilder(
    //             builder: (context, constraints) => Stack(
    //               alignment: Alignment.center,
    //               fit: StackFit.expand,
    //               children: [
    //                 Align(
    //                   alignment: Alignment.centerRight,
    //                   child: Container(
    //                     clipBehavior: Clip.hardEdge,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(5),
    //                       border: Border.all(
    //                         color: whiteColor,
    //                         strokeAlign: BorderSide.strokeAlignOutside,
    //                         width: 0.3,
    //                       ),
    //                     ),
    //                     child: CachedNetworkImage(
    //                       imageUrl:
    //                           'https://image.tmdb.org/t/p/w500/3vxvsmYLTf4jnr163SUlBIw51ee.jpg',
    //                       fit: BoxFit.fill,
    //                       filterQuality: FilterQuality.high,
    //                     ),
    //                   ),
    //                 ),
    //                 Align(
    //                   alignment: Alignment.center,
    //                   child: Container(
    //                     clipBehavior: Clip.hardEdge,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(5),
    //                       border: Border.all(
    //                         color: whiteColor,
    //                         strokeAlign: BorderSide.strokeAlignOutside,
    //                         width: 0.3,
    //                       ),
    //                     ),
    //                     child: CachedNetworkImage(
    //                       imageUrl:
    //                           'https://image.tmdb.org/t/p/w500/3vxvsmYLTf4jnr163SUlBIw51ee.jpg',
    //                       fit: BoxFit.fill,
    //                       filterQuality: FilterQuality.high,
    //                     ),
    //                   ),
    //                 ),
    //                 Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: Container(
    //                     clipBehavior: Clip.hardEdge,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(5),
    //                       border: Border.all(
    //                         color: whiteColor,
    //                         strokeAlign: BorderSide.strokeAlignOutside,
    //                         width: 0.3,
    //                       ),
    //                     ),
    //                     child: CachedNetworkImage(
    //                       imageUrl:
    //                           'https://image.tmdb.org/t/p/w500/3vxvsmYLTf4jnr163SUlBIw51ee.jpg',
    //                       fit: BoxFit.fill,
    //                       filterQuality: FilterQuality.high,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Flexible(
    //         flex: 1,
    //         child: Text(
    //           'Hello',
    //           textScaler: const TextScaler.linear(1),
    //           style: TextStyle(
    //             height: 3.h,
    //             fontSize: 15.sp,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
