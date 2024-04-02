import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/favorite/views/movie/bloc/favorite_movie_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoriteMovieView extends StatelessWidget {
  const FavoriteMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    int accountId = 11429392;
    return BlocProvider(
      create: (context) => FavoriteMovieBloc()
        ..add(FetchData(
          language: 'en-US',
          accountId: accountId,
          sessionId: sessionId,
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<FavoriteMovieBloc, FavoriteMovieState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
          if (state is FavoriteMovieSortSuccess) {
            bloc.add(LoadShimmer());
            bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            ));
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
          return SmartRefresher(
            physics: const BouncingScrollPhysics(),
            controller: bloc.controller,
            enablePullDown: state.listFavorite.isNotEmpty,
            enablePullUp: state.listFavorite.isNotEmpty,
            primary: false,
            header: const Header(),
            footer: Footer(
              height: 70.h,
              noMoreStatus: 'All favorite movies was loaded !',
              failedStatus: 'Failed to load Tv Shows !',
            ),
            onRefresh: () => bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            )),
            onLoading: () {
              bloc.add(LoadMore(
                language: 'en-US',
                accountId: accountId,
                sessionId: sessionId,
                sortBy: state.sortBy,
              ));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5.h),
                CustomDropDown(
                  title: state.sortBy,
                  icon: state.status ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  onTap: () => sortList(context, state.status, state.sortBy),
                ),
                BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                  builder: (context, state) {
                    if (state is FavoriteMovieInitial) {
                      return const Expanded(
                        child: CustomIndicator(
                          radius: 15,
                        ),
                      );
                    }
                    if (state is FavoriteMovieError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.errorMessage),
                        ),
                      );
                    }
                    if (state is FavoriteMovieSuccess && state.listFavorite.isEmpty) {
                      return CustomTextRich(
                        primaryText: 'Press',
                        secondaryText: 'to add to favorite movies',
                        icon: Icons.favorite,
                        color: yellowColor,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      controller: ScrollController(),
                      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 0),
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listFavorite.length,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<FavoriteMovieBloc>(context).state;
    final itemFavorite = state.listFavorite[index];
    return QuaternaryItem(
      title: itemFavorite.title ?? itemFavorite.name,
      voteAverage: itemFavorite.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: itemFavorite.releaseDate!.isNotEmpty
          ? AppUtils().formatDate(itemFavorite.releaseDate ?? '')
          : '00-00-0000',
      overview: itemFavorite.overview != '' ? itemFavorite.overview : 'Coming soon',
      originalLanguage: itemFavorite.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster}/${itemFavorite.posterPath}',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);

  sortList(BuildContext context, bool status, String sortBy) {
    final bloc = BlocProvider.of<FavoriteMovieBloc>(context);
    status
        ? bloc.add(Sort(status: false, sortBy: sortBy))
        : bloc.add(Sort(status: true, sortBy: sortBy));
  }
}
