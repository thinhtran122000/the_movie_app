import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Footer extends StatelessWidget {
  final double? height;
  final String? noMoreStatus;
  final String? failedStatus;
  const Footer({
    super.key,
    this.height,
    this.noMoreStatus,
    this.failedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: height ?? 0,
      builder: builder,
    );
  }

  Widget builder(BuildContext context, LoadStatus? mode) {
    switch (mode) {
      case LoadStatus.idle:
        return const SizedBox();
      case LoadStatus.canLoading:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: [darkBlueColor, darkBlueColor],
              ).createShader(bounds),
              child: Lottie.asset(
                AnimationsPath.loadingAnimation.assetName,
                height: 30.h,
                repeat: true,
                addRepaintBoundary: true,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      case LoadStatus.loading:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: [darkBlueColor, darkBlueColor],
              ).createShader(bounds),
              child: Lottie.asset(
                AnimationsPath.loadingAnimation.assetName,
                height: 30.h,
                repeat: true,
                addRepaintBoundary: true,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      case LoadStatus.failed:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: Text(
              failedStatus ?? 'Failed to load data!',
              textScaler: const TextScaler.linear(1),
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
        );
      case LoadStatus.noMore:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: Text(
              noMoreStatus ?? 'No more data!',
              textScaler: const TextScaler.linear(1),
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
