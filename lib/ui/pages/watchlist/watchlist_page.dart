

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/pages/watchlist/bloc/watchlist_bloc.dart';
import 'package:movie_app/ui/ui.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistBloc()..add(ChangeTab(index: 0)),
      child: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<WatchlistBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              centerTitle: true,
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
              title: const CustomAppBarTitle(titleAppBar: 'Watchlist'),
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
                        WatchlistMovieView(),
                        WatchlistTvView(),
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
