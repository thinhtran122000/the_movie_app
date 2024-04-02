import 'dart:async';
import 'dart:math';

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
      final nowPlayingResult = await exploreRepository.getNowPlayingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
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
      final discoveryResult = await exploreRepository.getDiscoverMovie(
        language: event.language,
        page: event.page,
        withGenres: event.withGenres,
      );
      emit(MovieSuccess(
        listTitle: state.listTitle,
        multipleList: [
          nowPlayingResult.list..shuffle(Random()..nextInt(nowPlayingResult.list.length)),
          popularResult.list..shuffle(Random()..nextInt(nowPlayingResult.list.length)),
          trendingResult.list..shuffle(Random()..nextInt(nowPlayingResult.list.length)),
          topRatedResult.list..shuffle(Random()..nextInt(nowPlayingResult.list.length)),
          upcomingResult.list..shuffle(Random()..nextInt(nowPlayingResult.list.length)),
          discoveryResult.list..shuffle(Random()..nextInt(nowPlayingResult.list.length)),
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
