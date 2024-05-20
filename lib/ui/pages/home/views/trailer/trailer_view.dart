import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/home/bloc/home_bloc.dart';
import 'package:tmdb/ui/pages/home/views/trailer/bloc/trailer_bloc.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/utils/debouncer/debouncer.dart';
import 'package:tmdb/utils/utils.dart';

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
      child: MultiBlocListener(
        listeners: [
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              final trailerState = BlocProvider.of<TrailerBloc>(context).state;
              final homeBloc = BlocProvider.of<HomeBloc>(context);
              switch (state.runtimeType) {
                case NavigationSuccess:
                  state.indexPage == 0
                      ? homeBloc.scrollController.position.pixels > 1100 &&
                              homeBloc.scrollController.position.pixels < 1550
                          ? checkDisplayVideo(context)
                              ? null
                              : playTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                          : checkDisplayVideo(context)
                              ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                              : null
                      : checkDisplayVideo(context)
                          ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                          : null;
                  break;
                case NavigationScrollSuccess:
                  state.indexPage == 0
                      ? checkDisplayVideo(context)
                          ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                          : null
                      : checkDisplayVideo(context)
                          ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                          : null;
                  break;
                default:
                  break;
              }
            },
          ),
          // disable trailer when tap other list type homepage
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              final trailerState = BlocProvider.of<TrailerBloc>(context).state;
              if (state is HomeDisableSuccess) {
                stopTrailer(context, trailerState.indexMovie, trailerState.indexTv);
              }
            },
          ),
        ],
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
                color: yellowColor,
              ),
              rightWidget: BlocBuilder<TrailerBloc, TrailerState>(
                builder: (context, state) {
                  if (state is TrailerError) {
                    return SizedBox(height: 22.h);
                  }
                  return CustomSwitchButton(
                    title: state.isActive ? 'Theaters' : 'TV',
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
                  firstChild: SizedBox(
                    height: 240.h,
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
                    height: 240.h,
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
                      },
                    ),
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
    return NonaryItem(
      heroTag: '${AppConstants.trailerMovieTag}-${item.id}',
      videoId: itemTrailer.key ?? '',
      enableVideo: bloc.state.visibleVideoMovie[index],
      title: item.title,
      scrollPosition: BlocProvider.of<HomeBloc>(context).scrollController.position.extentBefore,
      nameOfTrailer: (itemTrailer.name ?? '').isNotEmpty ? itemTrailer.name : 'Coming soon',
      imageUrl:
          item.backdropPath == null ? '' : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context, index, bloc.state.indexTv),
      onTapItem: () => navigateDetailPage(
        context,
        '${AppConstants.trailerMovieTag}-${item.id}',
        MediaType.movie,
        item.id ?? 0,
      ),
      onTapVideo: () => bloc.state.visibleVideoMovie[index]
          ? stopTrailer(context, index, bloc.state.indexTv)
          : playTrailer(context, index, bloc.state.indexTv),
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listTv[index];
    final itemTrailer = bloc.state.listTrailerTv[index];
    return NonaryItem(
      heroTag: '${AppConstants.trailerTvTag}-${item.id}',
      videoId: itemTrailer.key ?? '',
      enableVideo: bloc.state.visibleVideoTv[index],
      title: item.name,
      scrollPosition: BlocProvider.of<HomeBloc>(context).scrollController.position.extentBefore,
      nameOfTrailer: (itemTrailer.name ?? '').isNotEmpty ? itemTrailer.name : 'Coming soon',
      imageUrl:
          item.backdropPath == null ? '' : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context, bloc.state.indexMovie, index),
      onTapItem: () => navigateDetailPage(
        context,
        '${AppConstants.trailerTvTag}-${item.id}',
        MediaType.tv,
        item.id ?? 0,
      ),
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

  navigateDetailPage(BuildContext context, String heroTag, MediaType mediaType, int id) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    stopTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
    Navigator.of(context).pushNamed(
      AppMainRoutes.details,
      arguments: {
        'id': id,
        'media_type': mediaType,
        'hero_tag': heroTag,
      },
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
