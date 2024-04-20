import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/shared_ui/paths/icons_path.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/home/views/genre/bloc/genre_bloc.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';

class Genreview extends StatelessWidget {
  const Genreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchData(language: 'en-US')),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              return PrimaryText(
                title: 'Genres to explore',
                visibleIcon: true,
                enableRightWidget: true,
                icon: SvgPicture.asset(
                  IconsPath.genreIcon.assetName,
                  width: 24.sp,
                  height: 24.sp,
                ),
                rightWidget: BlocBuilder<GenreBloc, GenreState>(
                  builder: (context, state) {
                    if (state is GenreError) {
                      return SizedBox(height: 22.h);
                    }
                    return CustomSwitchButton(
                      title: state.status ? 'Movies' : 'Tv Shows',
                      onTapItem: () => state.status ? changeMovie(context) : changeTv(context),
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(height: 15.h),
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<GenreBloc>(context);
              if (state is GenreInitial) {
                return SizedBox(
                  height: 300.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is GenreError) {
                return SizedBox(
                  height: 300.h,
                  child: Center(
                    child: Text(state.errorMessage.toString()),
                  ),
                );
              }
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                crossFadeState: state.status ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: SizedBox(
                  height: 300.h,
                  child: GridView.custom(
                    controller: bloc.movieController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.h,
                      childAspectRatio: 0.6,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      itemBuilderMovie,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      childCount:
                          state.listGenreMovie.isNotEmpty ? state.listGenreMovie.length : 20,
                    ),
                  ),
                ),
                secondChild: SizedBox(
                  height: 300.h,
                  child: GridView.custom(
                    controller: bloc.tvController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.h,
                      childAspectRatio: 0.6,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      itemBuilderTv,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      childCount: state.listGenreTv.isNotEmpty ? state.listGenreTv.length : 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilderMovie(BuildContext context, int index) {
    final state = BlocProvider.of<GenreBloc>(context).state;
    final item = state.listGenreMovie.isNotEmpty ? state.listGenreMovie[index] : null;
    return PrimaryItem(
      title: item?.name,
      imageUrl: '${AppConstants.kImagePathBackdrop}${state.listMovieImage[index]}',
      color: AppUtils().getMovieGenreColor(item?.name ?? ''),
      onTapItem: () {},
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final state = BlocProvider.of<GenreBloc>(context).state;
    final item = state.listGenreTv.isNotEmpty ? state.listGenreTv[index] : null;
    return PrimaryItem(
      color: AppUtils().getTvGenreColor(item?.name ?? ''),
      title: item?.name,
      imageUrl: '${AppConstants.kImagePathBackdrop}${state.listTvImage[index]}',
      onTapItem: () {},
    );
  }

  changeMovie(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(ChangeList(status: false));
  }

  changeTv(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(ChangeList(status: true));
  }
}
