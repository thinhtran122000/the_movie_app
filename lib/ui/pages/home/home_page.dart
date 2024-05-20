import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/home/bloc/home_bloc.dart';
import 'package:tmdb/ui/pages/home/views/artist/artist.dart';
import 'package:tmdb/ui/pages/home/views/best_drama/best_drama.dart';
import 'package:tmdb/ui/pages/home/views/genre/genre.dart';
import 'package:tmdb/ui/pages/home/views/now_playing/now_playing.dart';
import 'package:tmdb/ui/pages/home/views/popular/popular.dart';
import 'package:tmdb/ui/pages/home/views/provider/provider.dart';
import 'package:tmdb/ui/pages/home/views/top_rated/top_rated.dart';
import 'package:tmdb/ui/pages/home/views/top_tv/top_tv.dart';
import 'package:tmdb/ui/pages/home/views/trailer/trailer_view.dart';
import 'package:tmdb/ui/pages/home/views/trending/trending.dart';
import 'package:tmdb/ui/pages/home/views/upcoming/upcoming.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(RefreshPage()),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar(
          appBarHeight: 30.h,
        ),
        body: BlocListener<TmdbBloc, TmdbState>(
          listener: (context, state) {
            if (state is TmdbLogoutSuccess) {
              BlocProvider.of<HomeBloc>(context).add(RefreshPage());
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<HomeBloc>(context);
              if (state is HomeInitial) {
                return Center(
                  child: CustomIndicator(
                    radius: 10.r,
                  ),
                );
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (bloc.scrollController.position.userScrollDirection ==
                      ScrollDirection.forward) {
                    showNavigationBar(context);
                    return false;
                  }
                  if (bloc.scrollController.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                    hideNavigationBar(context);
                    return false;
                  }
                  return false;
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: bloc.scrollController,
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20.h),
                          const PopularView(),
                          SizedBox(height: 30.h),
                          const Genreview(),
                          SizedBox(height: 30.h),
                          const TrendingView(),
                          SizedBox(height: 30.h),
                          const TopRatedView(),
                          SizedBox(height: 30.h),
                          const TrailerView(),
                          SizedBox(height: 30.h),
                          const UpcomingView(),
                          SizedBox(height: 30.h),
                          const NowPlayingView(),
                          SizedBox(height: 30.h),
                          const TopTvView(),
                          SizedBox(height: 30.h),
                          const BestDramaView(),
                          SizedBox(height: 30.h),
                          const ArtistView(),
                          SizedBox(height: 30.h),
                          // const BornToday(),
                          // SizedBox(height: 30.h),
                          const ProviderView(),
                          SizedBox(height: 110.h),
                        ],
                      ),
                    ),
                    CustomToast(
                      statusMessage: state.statusMessage,
                      opacity: state.opacity,
                      visible: state.visible,
                      onEndAnimation: () => state.opacity == 0.0
                          ? bloc.add(DisplayToast(
                              visible: false,
                              statusMessage: state.statusMessage,
                            ))
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  navigateProfilePage(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(NavigatePage(indexPage: 3));

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}

// void _incrementCounter() async {
//     try {
//       var list = await PopularService(apiClient: RestApiClient()).getPopularMovie();
//       // print('log: ${list.length} ');
//     } catch (e) {
//       Logger.debug(e.runtimeType.toString());
//     }
//   }

// SizedBox(
//   height: 18,
//   child: Center(
//     child: ListView.separated(
//       shrinkWrap: true,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         return Indicator(
//           isActive:
//               state.selectedIndex % images.length == index ? true : false,
//         );
//       },
//       separatorBuilder: (context, index) => const SizedBox(width: 2),
//       itemCount: images.length,
//     ),
//   ),
// ),

// SizedBox(
//   height: 200,
//   child: PageView.builder(
//     controller: pageController,
//     itemBuilder: itemBuilderPopular2,
//     onPageChanged: (value) {
//       bloc.add(SlidePageView(selectedIndex: value));
//     },
//   ),
// ),

// @override
// void initState() {
//   super.initState();
//   timer = Timer.periodic(const Duration(seconds: 5), (time) async {
//     final nexPage = (pageController.page?.toInt() ?? 0);
//     await pageController.animateToPage(
//       nexPage + 1,
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.ease,
//     );
//   });
// }

// @override
// void dispose() {
//   timer!.cancel();
//   pageController.dispose();
//   super.dispose();
// }
