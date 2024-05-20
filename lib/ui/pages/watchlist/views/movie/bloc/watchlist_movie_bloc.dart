import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistRepository watchListRepository = WatchlistRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  WatchlistMovieBloc()
      : super(WatchlistMovieInitial(
          listWatchList: [],
          status: true,
          sortBy: 'created_at.desc',
          listMovieState: [],
          index: 0,
          statusMessage: '',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<Sort>(_onSort);
    on<RemoveWatchlist>(_onRemoveWatchlist);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<WatchlistMovieState> emit) async {
    try {
      page = 1;
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await watchListRepository.getWatchListMovie(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listMovieState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final movieStateResult = await watchListRepository.getMovieState(
            movieId: e.id ?? 0,
            sessionId: sessionId,
          );
          return movieStateResult.object;
        },
      ).toList());
      if (result.list.isNotEmpty) {
        page++;
        emit(WatchlistMovieSuccess(
          listMovieState: listMovieState,
          listWatchList: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      } else {
        emit(WatchlistMovieSuccess(
          listWatchList: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          listMovieState: listMovieState,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      }
      controller.loadComplete();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
      state.listWatchList.clear();
      emit(WatchlistMovieError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        listMovieState: state.listMovieState,
        status: state.status,
        sortBy: event.sortBy ?? '',
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<WatchlistMovieState> emit) async {
    try {
      controller.requestLoading();
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await watchListRepository.getWatchListMovie(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listMovieState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final movieStateResult = await watchListRepository.getMovieState(
            movieId: e.id ?? 0,
            sessionId: sessionId,
          );
          return movieStateResult.object;
        },
      ).toList());
      final curentList = (state as WatchlistMovieSuccess).listWatchList;
      final currentListMovieState = (state as WatchlistMovieSuccess).listMovieState;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        final newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        final newListMovieState = List<MediaState>.from(currentListMovieState)
          ..addAll(listMovieState);
        emit(WatchlistMovieSuccess(
          listMovieState: newListMovieState,
          listWatchList: newList,
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
      emit(WatchlistMovieError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        listMovieState: state.listMovieState,
        status: state.status,
        sortBy: state.sortBy,
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<WatchlistMovieState> emit) {
    state.status
        ? emit(WatchlistMovieSortSuccess(
            listWatchList: state.listWatchList,
            listMovieState: state.listMovieState,
            status: event.status,
            sortBy: 'created_at.asc',
            index: state.index,
            statusMessage: state.statusMessage,
          ))
        : emit(WatchlistMovieSortSuccess(
            listWatchList: state.listWatchList,
            listMovieState: state.listMovieState,
            status: event.status,
            sortBy: 'created_at.desc',
            index: state.index,
            statusMessage: state.statusMessage,
          ));
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<WatchlistMovieState> emit) {
    emit(WatchlistMovieInitial(
      listWatchList: state.listWatchList,
      listMovieState: state.listMovieState,
      status: state.status,
      sortBy: state.sortBy,
      index: state.index,
      statusMessage: state.statusMessage,
    ));
  }

  FutureOr<void> _onRemoveWatchlist(
      RemoveWatchlist event, Emitter<WatchlistMovieState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey);
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      state.listMovieState[event.index].watchlist =
          !(state.listMovieState[event.index].watchlist ?? false);
      final result = await watchListRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId ?? '',
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listMovieState[event.index].watchlist ?? false,
      );
      emit(WatchlistMovieRemoveSuccess(
        listWatchList: state.listWatchList,
        listMovieState: state.listMovieState,
        statusMessage: result.object.statusMessage ?? '',
        sortBy: state.sortBy,
        status: state.status,
        index: event.index,
      ));
    } catch (e) {
      emit(WatchlistMovieError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        listMovieState: state.listMovieState,
        statusMessage: state.statusMessage,
        index: state.index,
        status: state.status,
        sortBy: state.sortBy,
      ));
    }
  }
}
