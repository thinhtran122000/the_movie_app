import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/details.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/upcoming/bloc/upcoming_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class UpcomingView extends StatelessWidget {
  const UpcomingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Comming soon to theaters',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.upcomingIcon.assetName,
              width: 20.w,
              height: 20.h,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<UpcomingBloc, UpcomingState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<UpcomingBloc>(context);
              if (state is UpcomingInitial) {
                return SizedBox(
                  height: 400.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is UpcomingError) {
                return SizedBox(
                  height: 400.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return CarouselSlider.builder(
                carouselController: bloc.controller,
                itemBuilder: itemBuilder,
                itemCount: state.listUpcoming.length,
                disableGesture: false,
                options: CarouselOptions(
                  height: 400.h,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    final state = BlocProvider.of<UpcomingBloc>(context).state;
    final item = state.listUpcoming[index];
    return SliderItem(
      heroTag: 'upcoming_movie_$index',
      isBackdrop: false,
      title: item.title,
      voteAverage: double.parse(item.voteAverage?.toStringAsFixed(1) ?? ''),
      imageUrlPoster:
          item.posterPath == null ? '' : '${AppConstants.kImagePathPoster}${item.posterPath}',
      onTap: () {
        BlocProvider.of<HomeBloc>(context).add(DisableTrailer());
        Navigator.of(context).push(
          CustomPageRoute(
            page: DetailsPage(
              heroTag: 'upcoming_movie_$index',
            ),
            begin: const Offset(1, 0),
          ),
        );
      },
    );
  }
}
