import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/favorite/favorite_repository.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'favorite_tv_event.dart';
part 'favorite_tv_state.dart';

class FavoriteTvBloc extends Bloc<FavoriteTvEvent, FavoriteTvState> {
  FavoriteRepository favoriteRepository = FavoriteRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  FavoriteTvBloc()
      : super(FavoriteTvInitial(
          listFavorite: [],
          status: true,
          sortBy: 'created_at.desc',
          index: 0,
          listState: [],
          statusMessage: '',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<Sort>(_onSort);
    on<AddWatchlist>(_onAddWatchlist);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<FavoriteTvState> emit) async {
    try {
      page = 1;
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await favoriteRepository.getFavoriteTv(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final stateResult = await favoriteRepository.getTvState(
            seriesId: e.id ?? 0,
            sessionId: sessionId,
          );
          return stateResult.object;
        },
      ).toList());
      if (result.list.isNotEmpty) {
        page++;
        emit(FavoriteTvSuccess(
          listFavorite: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          listState: listState,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      } else {
        emit(FavoriteTvSuccess(
          listFavorite: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          listState: listState,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      }
      controller.loadComplete();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
      state.listFavorite.clear();
      emit(FavoriteTvError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        status: state.status,
        sortBy: event.sortBy ?? '',
        index: state.index,
        listState: state.listState,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<FavoriteTvState> emit) async {
    try {
      controller.requestLoading();
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await favoriteRepository.getFavoriteTv(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final stateResult = await favoriteRepository.getTvState(
            seriesId: e.id ?? 0,
            sessionId: sessionId,
          );
          return stateResult.object;
        },
      ).toList());
      final curentList = (state as FavoriteTvSuccess).listFavorite;
      final currentListState = (state as FavoriteTvSuccess).listState;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        final newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        final newListState = List<MediaState>.from(currentListState)..addAll(listState);
        emit(FavoriteTvSuccess(
          listFavorite: newList,
          listState: newListState,
          status: state.status,
          sortBy: state.sortBy,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      state.listFavorite.clear();
      emit(FavoriteTvError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        status: state.status,
        sortBy: state.sortBy,
        index: state.index,
        listState: state.listState,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<FavoriteTvState> emit) {
    state.status
        ? emit(FavoriteTvSortSuccess(
            listFavorite: state.listFavorite,
            status: event.status,
            sortBy: 'created_at.asc',
            index: state.index,
            listState: state.listState,
            statusMessage: state.statusMessage,
          ))
        : emit(FavoriteTvSortSuccess(
            listFavorite: state.listFavorite,
            status: event.status,
            sortBy: 'created_at.desc',
            index: state.index,
            listState: state.listState,
            statusMessage: state.statusMessage,
          ));
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<FavoriteTvState> emit) {
    emit(FavoriteTvInitial(
      listFavorite: state.listFavorite,
      status: state.status,
      sortBy: state.sortBy,
      index: state.index,
      listState: state.listState,
      statusMessage: state.statusMessage,
    ));
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<FavoriteTvState> emit) async {
    try {
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      state.listState[event.index].watchlist = !(state.listState[event.index].watchlist ?? false);
      final result = await favoriteRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listState[event.index].watchlist ?? false,
      );
      emit(FavoriteTvAddWatchlistSuccess(
        listFavorite: state.listFavorite,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
        status: state.status,
        sortBy: state.sortBy,
      ));
    } catch (e) {
      emit(FavoriteTvAddWatchlistError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
        status: state.status,
        sortBy: state.sortBy,
      ));
    }
  }
}
