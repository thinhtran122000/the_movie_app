import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/home/views/genre/bloc/genre_bloc.dart';

class Genreview extends StatelessWidget {
  final bool isActive;
  const Genreview({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchData(language: 'en-US')),
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<GenreBloc>(context);
          if (state is GenreInitial) {
            return const SizedBox(
              height: 30,
            );
          }
          return Stack(
            children: [
              Visibility(
                visible: state.visibleMovie,
                child: AnimatedOpacity(
                  onEnd: () => bloc.add(VisbleList(
                    visibleMovie: false,
                    visibleTv: true,
                  )),
                  opacity: isActive ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      primary: true,
                      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: separatorBuilderMovie,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listGenreMovie.isNotEmpty ? state.listGenreMovie.length : 21,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: state.visibleTv,
                child: AnimatedOpacity(
                  onEnd: () => bloc.add(VisbleList(
                    visibleMovie: true,
                    visibleTv: false,
                  )),
                  opacity: isActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      primary: true,
                      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilderTv,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listGenreTv.isNotEmpty ? state.listGenreTv.length : 21,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget separatorBuilderMovie(BuildContext context, int index) {
    var list = BlocProvider.of<GenreBloc>(context).state.listGenreMovie;
    if (list.isEmpty) {
      return const SizedBox(
        height: 30,
        width: 53,
        child: CustomIndicator(),
      );
    } else {
      return PrimaryItemList(
        title: list[index].name,
        onTap: () {
          log('yeah');
        },
      );
    }
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    var list = BlocProvider.of<GenreBloc>(context).state.listGenreTv;
    if (list.isEmpty) {
      return const SizedBox(
        height: 30,
        width: 53,
        child: CustomIndicator(),
      );
    } else {
      return PrimaryItemList(
        title: list[index].name,
        onTap: () {},
      );
    }
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 10);
  }
}
