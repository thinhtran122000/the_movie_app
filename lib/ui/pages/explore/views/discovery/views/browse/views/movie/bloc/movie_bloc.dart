import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/explore.dart';
import 'package:movie_app/utils/utils.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());

  MovieBloc()
      : super(MovieInitial(
          multipleList: [],
          listTitle: [
            'Movie showtimes',
            'Popular movies',
            'Trending movies',
            'Top 250 movies',
            'Coming soon',
            'Most popular by genre',
            'Movie news',
          ],
        )) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<MovieState> emit) async {
    try {
      final upcomingResult = await exploreRepository.getUpcomingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      final popularResult = await exploreRepository.getPopularMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      final nowPlayingResult = (await exploreRepository.getNowPlayingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      ));
      final trendingResult = await exploreRepository.getTrendingMultiple(
        language: event.language,
        page: event.page,
        mediaType: event.mediaType,
        timeWindow: event.timeWindow,
        includeAdult: event.includeAdult,
      );
      final topRatedResult = await exploreRepository.getTopRatedMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      final genreResult = await exploreRepository.getGenreMovie(
        language: event.language,
      );
      final movieWithGenreResult = await Future.wait(
        genreResult.object.genres.map<Future<List<MultipleMedia>>>((e) async {
          final movieResult = await exploreRepository.getDiscoverMovie(
            language: event.language,
            page: 1,
            withGenres: [e.id ?? 0],
          );
          return movieResult.list;
        }).toList(),
      );
      final discoveryResult = movieWithGenreResult.map<MultipleMedia>((e) => (e).first).toList();
      nowPlayingResult.list.shuffle();
      popularResult.list.shuffle();
      trendingResult.list.shuffle();
      topRatedResult.list.shuffle();
      upcomingResult.list.shuffle();
      discoveryResult.shuffle();

      emit(MovieSuccess(
        listTitle: state.listTitle,
        multipleList: [
          nowPlayingResult.list.take(3).toList().reversed.toList(),
          popularResult.list.take(3).toList().reversed.toList(),
          trendingResult.list.take(3).toList().reversed.toList(),
          topRatedResult.list.take(3).toList().reversed.toList(),
          upcomingResult.list.take(3).toList().reversed.toList(),
          discoveryResult.take(3).toList().reversed.toList(),
        ],
      ));
    } catch (e) {
      emit(MovieError(
        errorMessage: e.toString(),
        listTitle: state.listTitle,
        multipleList: state.multipleList,
      ));
    }
  }
}
