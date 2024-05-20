import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/pages/watchlist/bloc/watchlist_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistBloc()
        ..add(NavigateTabWatchlist(
          indexTab: 0,
        )),
      child: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<WatchlistBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              centerTitle: true,
              title: 'Watchlist',
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomSegment(
                  widthSegment: double.infinity,
                  index: state.indexTab,
                  items: const ['Movie', 'TV Shows'],
                  onTapFirstItem: () => bloc.add(NavigateTabWatchlist(
                    indexTab: 0,
                  )),
                  onTapSecondItem: () => bloc.add(NavigateTabWatchlist(
                    indexTab: 1,
                  )),
                ),
                Expanded(
                  child: IndexedStack(
                    index: state.indexTab,
                    children: const [
                      WatchlistMovieView(),
                      WatchlistTvView(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
