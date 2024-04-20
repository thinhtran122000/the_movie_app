import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';

class DetailsPage extends StatelessWidget {
  final String? heroTag;
  final String? title;
  final int? id;
  const DetailsPage({
    super.key,
    this.heroTag,
    this.title,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: '$id',
        titleStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          color: whiteColor,
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
          size: 20.sp,
        ),
        onTapLeading: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: heroTag ?? '',
              child: CachedNetworkImage(
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
