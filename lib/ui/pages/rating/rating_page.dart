import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/rating/bloc/rating_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class RatingPage extends StatelessWidget {
  final int? id;
  final String? title;
  final String? imageUrl;
  final double? value;
  final MediaType? mediaType;
  const RatingPage({
    super.key,
    this.imageUrl,
    this.title,
    this.id,
    this.mediaType,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingBloc()
        ..add(FetchDataRating(
          value: value ?? 0.0,
        )),
      child: BlocConsumer<RatingBloc, RatingState>(
        listener: (context, state) async {
          if (state is RatingSuccess) {
            BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
              notificationTypes: NotificationTypes.rating,
            ));
            await Future.delayed(
              const Duration(milliseconds: 800),
              () => Navigator.of(context).pop(),
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<RatingBloc>(context);
          return PageStorage(
            bucket: PageStorageBucket(),
            child: Scaffold(
              body: Stack(
                // clipBehavior: Clip.hardEdge,
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 40,
                        sigmaY: 40,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl != null
                                  ? '${AppConstants.kImagePathPoster}$imageUrl'
                                  : '',
                              filterQuality: FilterQuality.high,
                              height: 200.h,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Image.asset(
                                ImagesPath.noImage.assetName,
                                width: double.infinity,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              color: blackColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async => state.value != value
                                  ? await showDialog(
                                      context: context,
                                      builder: (dialogContext) => CustomDialog(
                                        canPopDialog: true,
                                        title: 'Are you sure you want to discard?',
                                        titleFirstChoice: 'Cancel',
                                        titleSecondChoice: 'OK',
                                        isMultipleChoice: true,
                                        enabledContent: false,
                                        enabledTitle: true,
                                        titleStyle: TextStyle(
                                          color: darkBlueColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                        firstChoiceStyle: TextStyle(
                                          color: blackColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        secondChoiceStyle: TextStyle(
                                          color: redColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        onTapFirstChoice: () => Navigator.of(dialogContext).pop(),
                                        onTapSecondChoice: () => Navigator.of(dialogContext)
                                          ..pop()
                                          ..pop(),
                                      ),
                                    )
                                  : Navigator.of(context).pop(),
                              child: Icon(
                                Icons.close,
                                color: whiteColor,
                                size: 26.sp,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                imageUrl != null ? '${AppConstants.kImagePathPoster}$imageUrl' : '',
                            filterQuality: FilterQuality.none,
                            height: 250.h,
                            fit: BoxFit.fill,
                            color: state.value == 0 ? null : blackColor.withOpacity(0.3),
                            colorBlendMode: BlendMode.srcOver,
                          ),
                          Center(
                            child: Text(
                              state.value == 0 ? '' : state.value.toInt().toString(),
                              textScaler: const TextScaler.linear(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 130.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'How would you rate $title ?',
                          textAlign: TextAlign.center,
                          textScaler: const TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
                      RatingBar(
                        initialRating: state.value,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 10,
                        glow: false,
                        itemSize: 29.sp,
                        minRating: 1,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.w),
                        ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star_rounded,
                            color: yellowColor,
                            size: 28.sp,
                          ),
                          half: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) => LinearGradient(
                              stops: const [0.5, 0.5],
                              colors: [yellowColor, whiteColor],
                            ).createShader(bounds),
                            child: Icon(
                              Icons.star_half_rounded,
                              color: whiteColor,
                              size: 28.sp,
                            ),
                          ),
                          empty: Icon(
                            Icons.star_outline_rounded,
                            color: whiteColor,
                            size: 28.sp,
                          ),
                        ),
                        onRatingUpdate: (rating) => bloc.add(FetchDataRating(value: rating)),
                      ),
                      SizedBox(height: 40.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: RateButton(
                          buttonStyle: state.value > 0 ? ratingPrimaryStyle : ratingSecondaryStyle,
                          onTap: state.value > 0
                              ? () {
                                  bloc.add(AddRating(
                                    id: id ?? 0,
                                    mediaType: mediaType ?? MediaType.movie,
                                    value: state.value,
                                  ));
                                  BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                                    notificationTypes: NotificationTypes.rating,
                                  ));
                                }
                              : null,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      (value ?? 0.0) > 0.0
                          ? GestureDetector(
                              onTap: () {
                                bloc.add(RemoveRating(
                                  id: id ?? 0,
                                  mediaType: mediaType ?? MediaType.movie,
                                ));
                                BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                                  notificationTypes: NotificationTypes.rating,
                                ));
                              },
                              child: Text(
                                'Remove rating',
                                textScaler: const TextScaler.linear(1),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
