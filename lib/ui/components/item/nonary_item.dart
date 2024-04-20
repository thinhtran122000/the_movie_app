import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NonaryItem extends StatelessWidget {
  final String? title;
  final String imageUrl;
  final String? nameOfTrailer;
  final ObjectKey? youtubeKey;
  final bool enableVideo;
  final String videoId;
  final String heroTag;
  final double? scrollPosition;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapVideo;
  final VoidCallback? onTapFullScreen;
  final Function(YoutubeMetaData)? onEnded;
  const NonaryItem({
    super.key,
    this.onTapItem,
    this.title,
    this.nameOfTrailer,
    this.onEnded,
    this.onTapVideo,
    this.youtubeKey,
    this.onTapFullScreen,
    this.scrollPosition,
    required this.videoId,
    required this.imageUrl,
    required this.enableVideo,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(17.h, 5.h, 17.h, 5.h),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: greyColor,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: enableVideo
                  ? VideoPLayer(
                      enableVideo: enableVideo,
                      videoId: videoId,
                      heroTag: heroTag,
                      imageUrl: imageUrl,
                      title: title,
                      onTapItem: onTapItem,
                      onTapVideo: onTapVideo,
                      onEnded: onEnded,
                      scrollPosition: scrollPosition,
                      youtubeKey: youtubeKey,
                      onTapFullScreen: onTapFullScreen,
                    )
                  : GestureDetector(
                      onTap: enableVideo ? null : onTapVideo,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: Hero(
                              tag: heroTag,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder: (context, url, progress) =>
                                    const CustomIndicator(),
                                errorWidget: (context, url, error) => Image.asset(
                                  ImagesPath.noImage.assetName,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.play_arrow_rounded,
                            color: whiteColor,
                            size: 50.sp,
                            shadows: [
                              BoxShadow(
                                color: greyColor,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(height: 5.h),
          InkWell(
            onTap: onTapItem,
            child: SizedBox(
              width: 300.w,
              child: Text(
                '$title - $nameOfTrailer',
                softWrap: true,
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
