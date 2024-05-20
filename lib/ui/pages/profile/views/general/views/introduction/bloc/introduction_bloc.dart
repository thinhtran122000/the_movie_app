import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

part 'introduction_event.dart';
part 'introduction_state.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  final ProfileRepository profileRepository = ProfileRepository(restApiClient: RestApiClient());
  IntroductionBloc()
      : super(IntroductionInitial(
          hasAccount: false,
          profilePath: '',
          username: '',
          name: 'Sign in',
          id: 0,
          listTitle: ['Ratings', 'Favorites', 'Watchlist'],
          multipleList: [],
        )) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<IntroductionState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      if (accessToken != null) {
        final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
        final profileResult = await profileRepository.getProfile(sessionId: sessionId);
        final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');

        final ratedMovieResult = await profileRepository.getRatedMovie(
          accountId: accountId,
          sessionId: sessionId,
          language: event.language,
          sortBy: event.sortBy,
          page: 1,
        );

        final ratedTvResult = await profileRepository.getRatedTv(
          accountId: accountId,
          sessionId: sessionId,
          language: event.language,
          sortBy: event.sortBy,
          page: 1,
        );

        final favoriteMovieResult = await profileRepository.getFavoriteMovie(
          accountId: accountId,
          sessionId: sessionId,
          language: event.language,
          sortBy: event.sortBy,
          page: 1,
        );

        final favoriteTvResult = await profileRepository.getFavoriteTv(
          accountId: accountId,
          sessionId: sessionId,
          language: event.language,
          sortBy: event.sortBy,
          page: 1,
        );
        final watchlistMovieResult = await profileRepository.getWatchListMovie(
          accountId: accountId,
          sessionId: sessionId,
          language: event.language,
          sortBy: event.sortBy,
          page: 1,
        );
        final watchlistTvResult = await profileRepository.getWatchListTv(
          accountId: accountId,
          sessionId: sessionId,
          language: event.language,
          sortBy: event.sortBy,
          page: 1,
        );
        final rated = ratedMovieResult.list.followedBy(ratedTvResult.list).toList();
        final favorites = favoriteMovieResult.list.followedBy(favoriteTvResult.list).toList();
        final watchlist = watchlistMovieResult.list.followedBy(watchlistTvResult.list).toList();
        emit(IntroductionSuccess(
          id: profileResult.object.id ?? 0,
          name: profileResult.object.name ?? '',
          username: profileResult.object.username ?? '',
          profilePath: profileResult.object.avatar?.gravatar?.hash ?? '',
          hasAccount: true,
          listTitle: state.listTitle,
          multipleList: [
            rated,
            favorites,
            watchlist,
          ],
        ));
      } else {
        emit(IntroductionSuccess(
          id: state.id,
          name: 'Sign in',
          username: state.username,
          profilePath: state.profilePath,
          hasAccount: false,
          listTitle: state.listTitle,
          multipleList: state.multipleList,
        ));
      }
    } catch (e) {
      emit(IntroductionError(
        errorMessage: e.toString(),
        id: state.id,
        name: state.name,
        username: state.username,
        profilePath: state.profilePath,
        hasAccount: state.hasAccount,
        listTitle: state.listTitle,
        multipleList: state.multipleList,
      ));
    }
  }
}
