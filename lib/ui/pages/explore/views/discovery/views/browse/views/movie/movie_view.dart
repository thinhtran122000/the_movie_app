import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/explore/views/discovery/views/browse/views/movie/bloc/movie_bloc.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()
        ..add(FetchData(
          mediaType: 'movie',
          page: 1,
          language: 'en-US',
          includeAdult: true,
          withGenres: [12],
          timeWindow: 'day',
          region: '',
          timezone: '',
        )),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial) {
            return Center(
              child: SizedBox(
                height: 200.h,
                child: const CustomIndicator(
                  radius: 10,
                ),
              ),
            );
          }
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Container(
                  width: double.infinity,
                  color: whiteColor,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30.h),
                  Flexible(
                    flex: 1,
                    child: PrimaryText(
                      paddingLeft: 15.w,
                      paddingRight: 15.w,
                      title: 'Movie',
                      visibleIcon: true,
                      enableRightWidget: true,
                      onTapViewAll: () {
                        // Navigator.of(context).pushNamed(
                        //   '/authentication',
                        //   arguments: {
                        //     'is_later_login': true,
                        //     'route': '/navigation/explore',
                        //   },
                        // ).then(
                        //   (results) {
                        //     PopWithResults popResult = results as PopWithResults;
                        //     if (popResult.toPage == '/navigation/explore') {
                        //       log('Hello ${popResult.results?.values.toList()}');
                        //     }
                        //   },
                        // );
                      },
                      icon: Icon(
                        Icons.local_movies_rounded,
                        color: yellowColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: MasonryGridView.count(
                      padding: EdgeInsets.fromLTRB(13.w, 17.h, 13.w, 17.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      itemCount: state.multipleList.length,
                      itemBuilder: itemBuilder,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<MovieBloc>(context);
    return DenariItem(
      title: bloc.state.listTitle[index],
      multipleList: bloc.state.multipleList[index],
      onTapItem: () {},
    );
  }
}
