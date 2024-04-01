import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/details.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/top_rated/bloc/top_rated_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    return BlocProvider(
      create: (context) => TopRatedBloc()
        ..add(FetcData(
          page: 1,
          language: 'en-US',
          region: '',
          sessionId: sessionId,
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Top 10 rated movies',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.topRatedIcon.assetName,
            ),
          ),
          SizedBox(height: 15.h),
          BlocConsumer<TopRatedBloc, TopRatedState>(
            listener: (context, state) {
              final homeBloc = BlocProvider.of<HomeBloc>(context);
              if (state is TopRatedAddWatchListSuccess) {
                showToast(
                    context,
                    (state.listMovieState[state.index].watchlist ?? false)
                        ? '${state.listTopRated[state.index].title} was added to Watchlist'
                        : '${state.listTopRated[state.index].title} was removed from Watchlist');
              }
              if (state is TopRatedAddWatchListError) {
                homeBloc.add(DisplayToast(
                  visible: true,
                  statusMessage: state.errorMessage,
                ));
                homeBloc.add(ChangeAnimationToast(opacity: 1.0));
                Timer(
                  const Duration(seconds: 2),
                  () => homeBloc.add(ChangeAnimationToast(opacity: 0.0)),
                );
              }
            },
            builder: (context, state) {
              if (state is TopRatedInitial) {
                return SizedBox(
                  height: 285.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is TopRatedError) {
                return SizedBox(
                  height: 285.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return SizedBox(
                height: 285.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: itemBuilder,
                  separatorBuilder: separatorBuilder,
                  itemCount: (state.listTopRated.length / 2).round(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final item = bloc.state.listTopRated[index];
    return SenaryItem(
      heroTag: 'top_rated_movie_$index',
      title: item.title ?? '',
      rank: '${index + 1}',
      voteAverage: double.parse((item.voteAverage ?? 0).toStringAsFixed(1)),
      imageUrl: item.posterPath == null ? '' : '${AppConstants.kImagePathPoster}${item.posterPath}',
      watchlist: bloc.state.listMovieState[index].watchlist ?? false,
      onTapBanner: () => (bloc.state.listMovieState[index].watchlist ?? false)
          ? showCupertinoModalPopup(
              context: context,
              builder: (secondContext) => CustomBottomSheet(
                title: '${item.title} (${item.releaseDate?.substring(0, 4)})',
                titleConfirm: 'Remove from Watchlist',
                titleCancel: 'Cancel',
                onPressCancel: () => Navigator.of(secondContext).pop(),
                onPressConfirm: () => removeWatchList(context, secondContext, index),
              ),
            )
          : addWatchList(context, index),
      onTapItem: () {
        BlocProvider.of<HomeBloc>(context).add(DisableTrailer());
        Navigator.of(context).push(
          CustomPageRoute(
            page: DetailsPage(
              heroTag: 'top_rated_movie_$index',
            ),
            begin: const Offset(1, 0),
          ),
        );
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);

  addWatchList(BuildContext context, int index) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    bloc.add(AddWatchList(
      accountId: 11429392,
      sessionId: sessionId,
      mediaType: 'movie',
      mediaId: bloc.state.listTopRated[index].id ?? 0,
      index: index,
    ));
  }

  removeWatchList(BuildContext firstContext, BuildContext secondContext, int index) {
    addWatchList(firstContext, index);
    Navigator.of(secondContext).pop();
  }

  showToast(BuildContext context, String statusMessage) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final exploreBloc = BlocProvider.of<HomeBloc>(context);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => bloc.add(FetcData(
        page: 1,
        language: 'en-US',
        region: '',
        sessionId: sessionId,
      )),
    )
        .then(
          (_) => exploreBloc.add(DisplayToast(
            visible: true,
            statusMessage: statusMessage,
          )),
        )
        .then(
          (_) => exploreBloc.add(ChangeAnimationToast(opacity: 1.0)),
        );
    Timer(
      const Duration(seconds: 2),
      () => exploreBloc.add(ChangeAnimationToast(opacity: 0.0)),
    );
  }
}
