import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/colors/color.dart';
import 'package:tmdb/ui/pages/favorite/bloc/favorite_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()
        ..add(NavigateTabFavorite(
          indexTab: 0,
        )),
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<FavoriteBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              centerTitle: true,
              title: 'Favorites',
              titleStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: whiteColor,
              ),
              leading: Icon(
                Icons.arrow_back_ios,
                color: whiteColor,
                size: 20.sp,
              ),
              onTapLeading: () => Navigator.of(context).pop(),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomSegment(
                    widthSegment: double.infinity,
                    index: state.indexTab,
                    items: const ['Movie', 'TV Shows'],
                    onTapFirstItem: () => bloc.add(NavigateTabFavorite(
                      indexTab: 0,
                    )),
                    onTapSecondItem: () => bloc.add(NavigateTabFavorite(
                      indexTab: 1,
                    )),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: state.indexTab,
                      children: const [
                        FavoriteMovieView(),
                        FavoriteTvView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
