import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home_repository.dart';
import 'package:tmdb/utils/utils.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  TopRatedBloc()
      : super(TopRatedInitial(
          listTopRated: [],
          listState: [],
          statusMessage: '',
          index: 0,
        )) {
    on<FetchDataTopRated>(_onFetchDataTopRated);
    on<AddWatchlist>(_onAddWatchlist);
    on<AddFavorites>(_onAddFavorites);
  }

  FutureOr<void> _onFetchDataTopRated(FetchDataTopRated event, Emitter<TopRatedState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await homeRepository.getTopRatedMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      if (accessToken == null) {
        emit(TopRatedSuccess(
          listTopRated: result.list,
          listState: [],
          statusMessage: state.statusMessage,
          index: state.index,
        ));
      } else {
        final listState = await Future.wait(result.list.map<Future<MediaState>>(
          (e) async {
            final stateResult = await homeRepository.getMovieState(
              movieId: e.id ?? 0,
              sessionId: sessionId,
            );
            return stateResult.object;
          },
        ).toList());
        emit(TopRatedSuccess(
          listTopRated: result.list,
          listState: listState,
          statusMessage: state.statusMessage,
          index: state.index,
        ));
      }
    } catch (e) {
      emit(TopRatedError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<TopRatedState> emit) async {
    try {
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      state.listState[event.index].watchlist = !(state.listState[event.index].watchlist ?? false);
      final result = await homeRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listState[event.index].watchlist ?? false,
      );
      emit(TopRatedAddWatchlistSuccess(
        listTopRated: state.listTopRated,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TopRatedAddWatchlistError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<TopRatedState> emit) async {
    try {
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      state.listState[event.index].favorite = !(state.listState[event.index].favorite ?? false);
      final result = await homeRepository.addFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        favorite: state.listState[event.index].favorite ?? false,
      );
      emit(TopRatedAddFavoritesSuccess(
        listTopRated: state.listTopRated,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TopRatedAddFavoritesError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }
}
