import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  WatchlistRepository watchListRepository = WatchlistRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  WatchlistTvBloc()
      : super(WatchlistTvInitial(
          listWatchList: [],
          status: true,
          sortBy: 'created_at.desc',
          listTvState: [],
          index: 0,
          statusMessage: '',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<Sort>(_onSort);
    on<RemoveWatchlist>(_onRemoveWatchlist);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<WatchlistTvState> emit) async {
    try {
      page = 1;
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await watchListRepository.getWatchListTv(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listTvState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final tvStateResult = await watchListRepository.getTvState(
            seriesId: e.id ?? 0,
            sessionId: sessionId,
          );
          return tvStateResult.object;
        },
      ).toList());
      if (result.list.isNotEmpty) {
        page++;
        emit(WatchlistTvSuccess(
          listWatchList: result.list,
          listTvState: listTvState,
          status: state.status,
          sortBy: event.sortBy ?? '',
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      } else {
        emit(WatchlistTvSuccess(
          listWatchList: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          listTvState: listTvState,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      }
      controller.loadComplete();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
      state.listWatchList.clear();
      emit(WatchlistTvError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        listTvState: state.listTvState,
        status: state.status,
        sortBy: event.sortBy ?? '',
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<WatchlistTvState> emit) async {
    try {
      controller.requestLoading();
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await watchListRepository.getWatchListTv(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listTvState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final tvStateResult = await watchListRepository.getTvState(
            seriesId: e.id ?? 0,
            sessionId: sessionId,
          );
          return tvStateResult.object;
        },
      ).toList());
      final curentList = (state as WatchlistTvSuccess).listWatchList;
      final currentListTvState = (state as WatchlistTvSuccess).listTvState;

      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        final newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        final newListTvState = List<MediaState>.from(currentListTvState)..addAll(listTvState);
        emit(WatchlistTvSuccess(
          listWatchList: newList,
          listTvState: newListTvState,
          status: state.status,
          sortBy: state.sortBy,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      state.listWatchList.clear();
      emit(WatchlistTvError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        listTvState: state.listTvState,
        status: state.status,
        sortBy: state.sortBy,
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<WatchlistTvState> emit) {
    state.status
        ? emit(WatchlistTvSortSuccess(
            listWatchList: state.listWatchList,
            listTvState: state.listTvState,
            status: event.status,
            sortBy: 'created_at.asc',
            index: state.index,
            statusMessage: state.statusMessage,
          ))
        : emit(WatchlistTvSortSuccess(
            listWatchList: state.listWatchList,
            listTvState: state.listTvState,
            status: event.status,
            sortBy: 'created_at.desc',
            index: state.index,
            statusMessage: state.statusMessage,
          ));
  }

  FutureOr<void> _onRemoveWatchlist(RemoveWatchlist event, Emitter<WatchlistTvState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      state.listTvState[event.index].watchlist =
          !(state.listTvState[event.index].watchlist ?? false);
      final result = await watchListRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listTvState[event.index].watchlist ?? false,
      );
      emit(WatchlistTvRemoveSuccess(
        listWatchList: state.listWatchList,
        listTvState: state.listTvState,
        statusMessage: result.object.statusMessage ?? '',
        sortBy: state.sortBy,
        status: state.status,
        index: event.index,
      ));
    } catch (e) {
      emit(WatchlistTvError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        listTvState: state.listTvState,
        statusMessage: state.statusMessage,
        index: state.index,
        status: state.status,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<WatchlistTvState> emit) {
    emit(WatchlistTvInitial(
      listWatchList: state.listWatchList,
      listTvState: state.listTvState,
      status: state.status,
      sortBy: state.sortBy,
      index: state.index,
      statusMessage: state.statusMessage,
    ));
  }
}
