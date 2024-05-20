import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'top_tv_event.dart';
part 'top_tv_state.dart';

class TopTvBloc extends Bloc<TopTvEvent, TopTvState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController scrollController = ScrollController();
  TopTvBloc()
      : super(TopTvInitial(
          listState: [],
          listTopTv: [],
          index: 0,
          statusMessage: '',
        )) {
    on<FetchDataTopTv>(_onFetchDataTopTv);
    on<AddWatchlist>(_onAddWatchlist);
    on<AddFavorites>(_onAddFavorites);
  }

  FutureOr<void> _onFetchDataTopTv(FetchDataTopTv event, Emitter<TopTvState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await homeRepository.getTopRatedTv(
        language: event.language,
        page: event.page,
      );

      if (accessToken == null) {
        emit(TopTvSuccess(
          listTopTv: result.list,
          listState: [],
          statusMessage: state.statusMessage,
          index: state.index,
        ));
      } else {
        final listState = await Future.wait(result.list.map<Future<MediaState>>(
          (e) async {
            final stateResult = await homeRepository.getTvState(
              seriesId: e.id ?? 0,
              sessionId: sessionId,
            );
            return stateResult.object;
          },
        ).toList());
        emit(TopTvSuccess(
          listTopTv: result.list,
          listState: listState,
          statusMessage: state.statusMessage,
          index: state.index,
        ));
      }
    } catch (e) {
      emit(TopTvError(
        errorMessage: e.toString(),
        listTopTv: state.listTopTv,
        index: state.index,
        listState: state.listState,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<TopTvState> emit) async {
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
      emit(TopTvAddWatchlistSuccess(
        listTopTv: state.listTopTv,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TopTvAddWatchlistError(
        errorMessage: e.toString(),
        listTopTv: state.listTopTv,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<TopTvState> emit) async {
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
      emit(TopTvAddFavoritesSuccess(
        listTopTv: state.listTopTv,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TopTvAddFavoritesError(
        errorMessage: e.toString(),
        listTopTv: state.listTopTv,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }
}
