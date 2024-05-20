import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'best_drama_event.dart';
part 'best_drama_state.dart';

class BestDramaBloc extends Bloc<BestDramaEvent, BestDramaState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController scrollController = ScrollController();
  BestDramaBloc()
      : super(BestDramaInitial(
          listBestDrama: [],
          listState: [],
          index: 0,
          statusMessage: '',
        )) {
    on<FetchDataBestDrama>(_onFetchDataBestDrama);
    on<AddWatchlist>(_onAddWatchlist);
    on<AddFavorites>(_onAddFavorites);
  }

  FutureOr<void> _onFetchDataBestDrama(
      FetchDataBestDrama event, Emitter<BestDramaState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await homeRepository.getDiscoverTv(
        language: event.language,
        page: event.page,
        withGenres: event.withGenres,
      );
      if (accessToken == null) {
        emit(BestDramaSuccess(
          listBestDrama: result.list,
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
        emit(BestDramaSuccess(
          listBestDrama: result.list,
          listState: listState,
          statusMessage: state.statusMessage,
          index: state.index,
        ));
      }
    } catch (e) {
      emit(BestDramaError(
        errorMessage: e.toString(),
        listBestDrama: state.listBestDrama,
        listState: state.listState,
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<BestDramaState> emit) async {
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
      emit(BestDramaAddWatchlistSuccess(
        listBestDrama: state.listBestDrama,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(BestDramaAddWatchlistError(
        errorMessage: e.toString(),
        listBestDrama: state.listBestDrama,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<BestDramaState> emit) async {
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
      emit(BestDramaAddFavoritesSuccess(
        listBestDrama: state.listBestDrama,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(BestDramaAddFavoritesError(
        errorMessage: e.toString(),
        listBestDrama: state.listBestDrama,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }
}
