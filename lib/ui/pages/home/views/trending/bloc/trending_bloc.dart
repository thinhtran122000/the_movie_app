import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController scrollController = ScrollController();
  TrendingBloc()
      : super(TrendingInitial(
          listTrending: [],
          listState: [],
          statusMessage: '',
          index: 0,
        )) {
    on<FetchDataTrending>(_onFetchDataTrending);
    on<AddWatchlist>(_onAddWatchlist);
    on<AddFavorites>(_onAddFavorites);
  }

  FutureOr<void> _onFetchDataTrending(FetchDataTrending event, Emitter<TrendingState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      var result = await homeRepository.getTrendingMultiple(
        mediaType: event.mediaType,
        timeWindow: event.timeWindow,
        page: event.page,
        language: event.language,
        includeAdult: event.includeAdult,
      );
      if (accessToken == null) {
        emit(TrendingSuccess(
          listTrending: result.list,
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
        emit(TrendingSuccess(
          listTrending: result.list,
          listState: listState,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      }
    } catch (e) {
      emit(TrendingError(
        errorMessage: e.toString(),
        listTrending: state.listTrending,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<TrendingState> emit) async {
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
      emit(TrendingAddWatchlistSuccess(
        listTrending: state.listTrending,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TrendingAddWatchlistError(
        errorMessage: e.toString(),
        listTrending: state.listTrending,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<TrendingState> emit) async {
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
      emit(TrendingAddFavoritesSuccess(
        listTrending: state.listTrending,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TrendingAddFavoritesError(
        errorMessage: e.toString(),
        listTrending: state.listTrending,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }
}
