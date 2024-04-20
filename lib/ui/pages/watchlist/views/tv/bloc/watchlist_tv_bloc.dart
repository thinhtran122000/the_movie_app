import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<Sort>(_onSort);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<WatchlistTvState> emit) async {
    try {
      page = 1;
      final result = await watchListRepository.getWatchListTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      if (result.list.isNotEmpty) {
        page++;
        emit(WatchlistTvSuccess(
          listWatchList: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
        ));
      } else {
        emit(WatchlistTvSuccess(
          listWatchList: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
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
        status: state.status,
        sortBy: event.sortBy ?? '',
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<WatchlistTvState> emit) async {
    try {
      controller.requestLoading();
      final result = await watchListRepository.getWatchListTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      var curentList = (state as WatchlistTvSuccess).listWatchList;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        var newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        emit(WatchlistTvSuccess(
          listWatchList: newList,
          status: state.status,
          sortBy: state.sortBy,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      state.listWatchList.clear();
      emit(WatchlistTvError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        status: state.status,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<WatchlistTvState> emit) {
    state.status
        ? emit(WatchlistTvSortSuccess(
            listWatchList: state.listWatchList,
            status: event.status,
            sortBy: 'created_at.asc',
          ))
        : emit(WatchlistTvSortSuccess(
            listWatchList: state.listWatchList,
            status: event.status,
            sortBy: 'created_at.desc',
          ));
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<WatchlistTvState> emit) {
    emit(WatchlistTvInitial(
      listWatchList: state.listWatchList,
      status: state.status,
      sortBy: state.sortBy,
    ));
  }
}
