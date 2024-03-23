import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/details.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/trailer/bloc/trailer_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  const TrailerView({super.key});

  @override
  State<TrailerView> createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrailerBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          final trailerState = BlocProvider.of<TrailerBloc>(context).state;
          final exploreBloc = BlocProvider.of<ExploreBloc>(context);
          switch (state.runtimeType) {
            case NavigationSuccess:
              state.indexPage == 1
                  ? trailerState is TrailerSuccess
                      ? exploreBloc.scrollController.position.extentBefore <= 0
                          ? checkDisplayVideo(context)
                              ? null
                              : playTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                          : checkDisplayVideo(context)
                              ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                              : null
                      : stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                  : checkDisplayVideo(context)
                      ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                      : null;
              break;
            case NavigationScrollSuccess:
              state.indexPage == 1
                  ? trailerState is TrailerSuccess
                      ? checkDisplayVideo(context)
                          ? null
                          : playTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                      : stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                  : checkDisplayVideo(context)
                      ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                      : null;
              break;
            default:
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PrimaryText(
              title: 'TMDb Originals',
              visibleIcon: true,
              enableRightWidget: true,
              icon: Icon(
                Icons.video_library_rounded,
                size: 24,
                color: greyColor,
              ),
              rightWidget: BlocBuilder<TrailerBloc, TrailerState>(
                builder: (context, state) {
                  if (state is TrailerError) {
                    return SizedBox(height: 22.h);
                  }
                  return CustomSwitchButton(
                    title: state.isActive ? 'TV' : 'Theaters',
                    onTapItem: () => state.isActive ? changeMovie(context) : changeTv(context),
                  );
                },
              ),
            ),
            SizedBox(height: 15.h),
            BlocBuilder<TrailerBloc, TrailerState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<TrailerBloc>(context);
                if (state is TrailerInitial) {
                  return SizedBox(
                    height: 240.h,
                    child: const CustomIndicator(radius: 10),
                  );
                }
                if (state is TrailerError) {
                  return SizedBox(
                    height: 240.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                      state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Container(
                    height: 350.h,
                    color: Colors.red,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      controller: bloc.movieController,
                      itemCount: state.listMovie.length,
                      itemBuilder: itemBuilderMovie,
                      onPageChanged: (value) {
                        stopTrailer(context, state.indexMovie, state.indexTv);
                        bloc.state.visibleVideoMovie[value]
                            ? null
                            : playTrailer(context, value, state.indexTv);
                      },
                    ),
                  ),
                  secondChild: SizedBox(
                    height: 350.h,
                    child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        allowImplicitScrolling: true,
                        controller: bloc.tvController,
                        itemCount: state.listTv.length,
                        itemBuilder: itemBuilderTv,
                        onPageChanged: (value) {
                          stopTrailer(context, state.indexMovie, state.indexTv);
                          bloc.state.visibleVideoTv[value]
                              ? null
                              : playTrailer(context, state.indexMovie, value);
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilderMovie(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listMovie[index];
    final itemTrailer = bloc.state.listTrailerMovie[index];
    final controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: YoutubePlayerFlags(
        hideControls: (itemTrailer.key ?? '').isEmpty ? true : false,
        autoPlay: bloc.state.visibleVideoMovie[index] ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        forceHD: false,
      ),
    );
    return QuinaryItem(
      videoId: itemTrailer.key ?? '',
      youtubeKey: ObjectKey(controller),
      controller: controller,
      enableVideo: bloc.state.visibleVideoMovie[index],
      title: item.title,
      overview: (item.overview ?? '').isNotEmpty ? item.overview : 'No description',
      voteAverage: double.parse((item.voteAverage ?? 0).toStringAsFixed(1)),
      type: (itemTrailer.type ?? '').isNotEmpty ? '(Official ${itemTrailer.type})' : '',
      releaseDate: (item.releaseDate ?? '').isNotEmpty
          ? AppUtils().formatDate(item.releaseDate ?? '')
          : 'Coming soon',
      imageUrl:
          item.backdropPath == null ? '' : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context, index, bloc.state.indexTv),
      onTapItem: () => navigateDetailPage(context),
      onTapVideo: () => bloc.state.visibleVideoMovie[index]
          ? stopTrailer(context, index, bloc.state.indexTv)
          : playTrailer(context, index, bloc.state.indexTv),
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listTv[index];
    final itemTrailer = bloc.state.listTrailerTv[index];
    final controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: YoutubePlayerFlags(
        hideControls: (itemTrailer.key ?? '').isEmpty ? true : false,
        autoPlay: bloc.state.visibleVideoTv[index] ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        forceHD: false,
      ),
    );
    return QuinaryItem(
      videoId: itemTrailer.key ?? '',
      youtubeKey: ObjectKey(controller),
      controller: controller,
      enableVideo: bloc.state.visibleVideoTv[index],
      title: item.name,
      overview: (item.overview ?? '').isNotEmpty ? item.overview : 'No description',
      voteAverage: double.parse((item.voteAverage ?? 0).toStringAsFixed(1)),
      type: (itemTrailer.type ?? '').isNotEmpty ? '(Official ${itemTrailer.type})' : '',
      releaseDate: (item.firstAirDate ?? '').isNotEmpty
          ? AppUtils().formatDate(item.firstAirDate ?? '')
          : '',
      imageUrl:
          item.backdropPath == null ? '' : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context, bloc.state.indexMovie, index),
      onTapItem: () => navigateDetailPage(context),
      onTapVideo: () => bloc.state.visibleVideoTv[index]
          ? stopTrailer(context, bloc.state.indexMovie, index)
          : playTrailer(context, bloc.state.indexMovie, index),
    );
  }

  changeMovie(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(ChangeType(isActive: false));
    playTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
  }

  changeTv(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(ChangeType(isActive: true));
    playTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
  }

  navigateDetailPage(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    stopTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
    Navigator.of(context)
        .push(CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ))
        .then(
          (_) => playTrailer(context, bloc.state.indexMovie, bloc.state.indexTv),
        );
  }

  playTrailer(BuildContext context, int indexMovie, int indexTv) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    debouncer.delay(
      () => bloc.add(PlayTrailer(
        indexMovie: indexMovie,
        indexTv: indexTv,
        isActive: bloc.state.isActive,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
    );
  }

  stopTrailer(BuildContext context, int indexMovie, int indexTv) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(StopTrailer(
      indexMovie: indexMovie,
      indexTv: indexTv,
      isActive: bloc.state.isActive,
      visibleVideoMovie: bloc.state.visibleVideoMovie,
      visibleVideoTv: bloc.state.visibleVideoTv,
    ));
  }

  bool checkDisplayVideo(BuildContext context) {
    final trailerState = BlocProvider.of<TrailerBloc>(context).state;
    return trailerState.visibleVideoMovie[trailerState.indexMovie] ||
        trailerState.visibleVideoTv[trailerState.indexTv];
  }
}
