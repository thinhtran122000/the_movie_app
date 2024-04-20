import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/details/details.dart';
import 'package:tmdb/ui/pages/home/views/trending/bloc/trending_bloc.dart';
import 'package:tmdb/utils/utils.dart';

class TrendingView extends StatelessWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingBloc()
        ..add(FetchData(
          mediaType: 'movie',
          timeWindow: 'day',
          page: 1,
          language: 'en-US',
          includeAdult: true,
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Trending today',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.trendingIcon.assetName,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<TrendingBloc, TrendingState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<TrendingBloc>(context);
              if (state is TrendingInitial) {
                return SizedBox(
                  height: 275.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is TrendingError) {
                return SizedBox(
                  height: 275.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return Stack(
                children: [
                  const Positioned.fill(
                    child: PrimaryBackground(),
                  ),
                  SizedBox(
                    height: 275.h,
                    child: ListView.separated(
                      controller: bloc.scrollController,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listTrending.isNotEmpty ? state.listTrending.length + 1 : 21,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<TrendingBloc>(context).state;
    final list = state.listTrending;
    final item = index < list.length ? list[index] : null;
    return TertiaryItem(
      heroTag: '${AppConstants.trendingMovieHeroTag}-$index',
      enableInfo: true,
      index: index,
      itemCount: list.length,
      title: item?.title ?? item?.name,
      voteAverage: double.parse((item?.voteAverage ?? 0).toStringAsFixed(1)),
      imageUrl:
          item?.posterPath == null ? '' : '${AppConstants.kImagePathPoster}${item?.posterPath}',
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        AppPageRoute(
          builder: (context) => DetailsPage(heroTag: '${AppConstants.trendingMovieHeroTag}-$index'),
          begin: const Offset(1, 0),
        ),
      ),
      onTapBanner: () {
        print('Hello');
      },
      onTapFavor: () {
        print('Hello');
      },
      onTapInfo: () {
        print('Hello');
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);
}
