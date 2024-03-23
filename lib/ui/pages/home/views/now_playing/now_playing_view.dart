import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/details.dart';
import 'package:movie_app/ui/pages/home/views/now_playing/bloc/now_playing_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
        )),
      child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(
                title: 'On streaming now',
                visibleIcon: true,
                onTapViewAll: () {},
                icon: SvgPicture.asset(
                  IconsPath.nowPlayingIcon.assetName,
                ),
              ),
              SizedBox(height: 15.h),
              BlocConsumer<NowPlayingBloc, NowPlayingState>(
                listener: (context, state) {
                  final bloc = BlocProvider.of<NowPlayingBloc>(context);
                  state.paletteColors.isEmpty && state is NowPlayingSuccess
                      ? bloc.add(ChangeColor(
                          posterPath: (state.nowPlayingTv.posterPath ?? '').isNotEmpty
                              ? '${AppConstants.kImagePathPoster}${state.nowPlayingTv.posterPath}'
                              : ImagesPath.noImage.assetName,
                        ))
                      : null;
                },
                builder: (context, state) {
                  if (state is NowPlayingInitial) {
                    return SizedBox(
                      height: 172.h,
                      child: const CustomIndicator(),
                    );
                  }
                  if (state is NowPlayingError) {
                    return SizedBox(
                      height: 172.h,
                      child: Center(
                        child: Text(state.runtimeType.toString()),
                      ),
                    );
                  }
                  final item = state.nowPlayingTv;
                  return SingleItem(
                    heroTag: AppConstants.nowPlayingTvHeroTag,
                    title: item.name,
                    season: item.lastEpisodeToAir?.seasonNumber,
                    episode: item.lastEpisodeToAir?.episodeNumber,
                    overview: item.overview != '' ? item.overview : 'Comming soon',
                    averageLuminance: state.averageLuminance,
                    posterPath: item.posterPath,
                    imageUrl: '${AppConstants.kImagePathPoster}${item.posterPath}',
                    colors: state.paletteColors,
                    stops: state.paletteColors.asMap().keys.toList().map((e) => e * 0.13).toList(),
                    onTapItem: () => Navigator.of(context).push(
                      CustomPageRoute(
                        page: const DetailsPage(
                          heroTag: AppConstants.nowPlayingTvHeroTag,
                        ),
                        begin: const Offset(1, 0),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
