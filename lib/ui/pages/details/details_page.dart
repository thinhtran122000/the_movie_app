import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class DetailsPage extends StatelessWidget {
  final String? heroTag;
  final String? title;
  const DetailsPage({
    super.key,
    this.heroTag,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: '$title',
        leading: Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
          size: 30,
        ),
        // title: const CustomAppBarTitle(
        //   titleAppBar: 'Details',
        // ),

        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
        //   child: Icon(
        //     Icons.star_outline_rounded,
        //     color: yellowColor,
        //     size: 25,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
        //   child: Icon(
        //     Icons.favorite_border_outlined,
        //     color: pinkColor,
        //     size: 25,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
        //   child: Icon(
        //     Icons.bookmark_outline_rounded,
        //     color: cyanColor,
        //     size: 25,
        //   ),
        // ),

        onTapLeading: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: heroTag ?? '',
              child:
                  // Container(
                  //   width: 300,
                  //   height: 300,
                  //   decoration: const BoxDecoration(
                  //     color: Colors.red,
                  //   ),
                  // ),
                  CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500/egg7KFi18TSQc1s24RMmR9i2zO6.jpg',
                filterQuality: FilterQuality.high,
                width: double.infinity,
                height: 190.h,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  ImagesPath.noImage.assetName,
                  width: double.infinity,
                  height: double.infinity,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
