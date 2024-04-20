import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/home/bloc/home_bloc.dart';
import 'package:tmdb/ui/pages/home/views/popular/bloc/popular_bloc.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/utils/utils.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularBloc()
        ..add(FetchData(
          page: 1,
          region: '',
          language: 'en-US',
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) async {
          final scrollController = BlocProvider.of<HomeBloc>(context).scrollController;
          final popularState = BlocProvider.of<PopularBloc>(context).state;
          switch (state.runtimeType) {
            case NavigationSuccess:
              state.indexPage == 0
                  ? scrollController.position.pixels <= 100
                      ? popularState.autoPlay
                          ? null
                          : BlocProvider.of<PopularBloc>(context).add(AutoSlide(autoPlay: true))
                      : popularState.autoPlay
                          ? BlocProvider.of<PopularBloc>(context).add(AutoSlide(autoPlay: false))
                          : null
                  : popularState.autoPlay
                      ? BlocProvider.of<PopularBloc>(context).add(AutoSlide(autoPlay: false))
                      : null;
              break;
            case NavigationScrollSuccess:
              state.indexPage == 0
                  ? scrollController.hasClients
                      ? await scrollController
                          .animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                          )
                          .then(
                            (value) => scrollController.position.pixels <= 100
                                ? popularState.autoPlay
                                    ? null
                                    : BlocProvider.of<PopularBloc>(context)
                                        .add(AutoSlide(autoPlay: true))
                                : popularState.autoPlay
                                    ? BlocProvider.of<PopularBloc>(context)
                                        .add(AutoSlide(autoPlay: false))
                                    : null,
                          )
                      : null
                  : null;
              break;
            default:
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryText(
              title: '''What popular to watch''',
              visibleIcon: true,
              onTapViewAll: () {},
              icon: SvgPicture.asset(
                IconsPath.popularIcon.assetName,
              ),
            ),
            SizedBox(height: 15.h),
            BlocBuilder<PopularBloc, PopularState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<PopularBloc>(context);
                if (state is PopularInitial) {
                  return SizedBox(
                    height: 200.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is PopularError) {
                  return SizedBox(
                    height: 200.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      carouselController: bloc.controller,
                      itemBuilder: itemBuilder,
                      itemCount: state.listPopular.isNotEmpty
                          ? (state.listPopular.length / 2).round()
                          : 10,
                      options: CarouselOptions(
                        autoPlayAnimationDuration: const Duration(milliseconds: 500),
                        autoPlay: state.autoPlay,
                        height: 200.h,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) =>
                            bloc.add(SlidePageView(selectedIndex: index)),
                      ),
                    ),
                    SliderIndicator(
                      indexIndicator: state.selectedIndex %
                          (state.listPopular.isNotEmpty
                              ? (state.listPopular.length / 2).round()
                              : 10),
                      length: state.listPopular.isNotEmpty
                          ? (state.listPopular.length / 2).round()
                          : 10,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    final state = BlocProvider.of<PopularBloc>(context).state;
    final item = state.listPopular.isNotEmpty ? state.listPopular[index] : null;
    return SliderItem(
      heroTag: '${AppConstants.popularMovieHeroTag}-$index',
      isBackdrop: true,
      imageUrlBackdrop: item?.backdropPath == null
          ? ''
          : '${AppConstants.kImagePathBackdrop}${item?.backdropPath}',
      onTap: () => Navigator.of(context).pushNamed(
        AppMainRoutes.details,
        arguments: {
          'hero_tag': '${AppConstants.popularMovieHeroTag}-$index',
          'id': item?.id,
        },
      ),
    );
  }

  enableAutoSlide(BuildContext context, int indexPage) {
    final bloc = BlocProvider.of<PopularBloc>(context);
    indexPage == 0
        // ? extentBefore <= 300
        ? bloc.state.autoPlay
            ? null
            : bloc.add(AutoSlide(autoPlay: true))
        : bloc.state.autoPlay
            ? bloc.add(AutoSlide(autoPlay: false))
            : null;
    // : bloc.add(AutoSlide(autoPlay: false));

    // print(
    //     'Popular ${bloc.state.autoPlay} ${BlocProvider.of<HomeBloc>(context).scrollController.position.pixels == BlocProvider.of<HomeBloc>(context).scrollController.position.minScrollExtent}');
  }
}
