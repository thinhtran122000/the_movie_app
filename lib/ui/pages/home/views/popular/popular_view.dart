import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/details.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/popular/bloc/popular_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/utils.dart';

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
        listener: (context, state) => enableAutoSlide(context, state.indexPage),
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
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: DetailsPage(heroTag: '${AppConstants.popularMovieHeroTag}-$index'),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  enableAutoSlide(BuildContext context, int indexPage) {
    final bloc = BlocProvider.of<PopularBloc>(context);
    indexPage == 0
        ? BlocProvider.of<HomeBloc>(context).scrollController.position.extentBefore <= 300
            ? bloc.state.autoPlay
                ? null
                : bloc.add(AutoSlide(autoPlay: true))
            : bloc.state.autoPlay
                ? bloc.add(AutoSlide(autoPlay: false))
                : null
        : null;
  }
}
