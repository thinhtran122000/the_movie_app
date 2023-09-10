import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/favorite/bloc/favorite_bloc.dart';
import 'package:movie_app/ui/pages/favorite/views/movie/index.dart';
import 'package:movie_app/ui/pages/favorite/views/tv/index.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()..add(ChangeTab(index: 0)),
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<FavoriteBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              centerTitle: true,
              leading: Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0, 0, 0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.sp,
                ),
              ),
              title: const CustomAppBarTitle(titleAppBar: 'Favorites'),
              onTapLeading: () => Navigator.of(context).pop(),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTabBar(
                    widthTabBar: double.infinity,
                    index: state.index,
                    onTapMovie: () => bloc.add(ChangeTab(index: 0)),
                    onTapTv: () => bloc.add(ChangeTab(index: 1)),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: state.index,
                      children: const [
                        MovieView(),
                        TvView(),
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
