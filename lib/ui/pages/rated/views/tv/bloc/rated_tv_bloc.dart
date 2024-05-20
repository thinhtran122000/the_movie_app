import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

part 'rated_tv_event.dart';
part 'rated_tv_state.dart';

class RatedTvBloc extends Bloc<RatedTvEvent, RatedTvState> {
  RatedRepository ratedRepository = RatedRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  RatedTvBloc()
      : super(RatedTvInitial(
          listRated: [],
          listTvState: [],
          status: true,
          sortBy: 'created_at.desc',
          index: 0,
          statusMessage: '',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<Sort>(_onSort);
    on<AddWatchlist>(_onAddWatchlist);
    on<AddFavorites>(_onAddFavorites);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<RatedTvState> emit) async {
    try {
      page = 1;
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await ratedRepository.getRatedTv(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listTvState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final tvStateResult = await ratedRepository.getTvState(
            seriesId: e.id ?? 0,
            sessionId: sessionId,
          );
          return tvStateResult.object;
        },
      ).toList());
      if (result.list.isNotEmpty) {
        page++;
        emit(RatedTvSuccess(
          listTvState: listTvState,
          listRated: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      } else {
        emit(RatedTvSuccess(
          listRated: result.list,
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
      state.listRated.clear();
      emit(RatedTvError(
        errorMessage: e.toString(),
        listRated: state.listRated,
        listTvState: state.listTvState,
        status: state.status,
        sortBy: event.sortBy ?? '',
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<RatedTvState> emit) async {
    try {
      controller.requestLoading();
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await ratedRepository.getRatedTv(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listMovieState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final movieStateResult = await ratedRepository.getTvState(
            seriesId: e.id ?? 0,
            sessionId: sessionId,
          );
          return movieStateResult.object;
        },
      ).toList());
      final curentList = (state as RatedTvSuccess).listRated;
      final currentListTvState = (state as RatedTvSuccess).listTvState;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        final newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        final newListTvState = List<MediaState>.from(currentListTvState)..addAll(listMovieState);
        emit(RatedTvSuccess(
          listTvState: newListTvState,
          listRated: newList,
          status: state.status,
          sortBy: state.sortBy,
          index: state.index,
          statusMessage: state.statusMessage,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      state.listRated.clear();
      emit(RatedTvError(
        errorMessage: e.toString(),
        listRated: state.listRated,
        listTvState: state.listTvState,
        status: state.status,
        sortBy: state.sortBy,
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<RatedTvState> emit) async {
    state.status
        ? emit(RatedTvSortSuccess(
            listRated: state.listRated,
            listTvState: state.listTvState,
            status: event.status,
            sortBy: 'created_at.asc',
            index: state.index,
            statusMessage: state.statusMessage,
          ))
        : emit(RatedTvSortSuccess(
            listRated: state.listRated,
            listTvState: state.listTvState,
            status: event.status,
            sortBy: 'created_at.desc',
            index: state.index,
            statusMessage: state.statusMessage,
          ));
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<RatedTvState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey);
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      state.listTvState[event.index].watchlist =
          !(state.listTvState[event.index].watchlist ?? false);
      final result = await ratedRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId ?? '',
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listTvState[event.index].watchlist ?? false,
      );
      emit(RatedTvAddWatchlistSuccess(
        listRated: state.listRated,
        listTvState: state.listTvState,
        statusMessage: result.object.statusMessage ?? '',
        sortBy: state.sortBy,
        status: state.status,
        index: event.index,
      ));
    } catch (e) {
      emit(RatedTvError(
        errorMessage: e.toString(),
        listRated: state.listRated,
        listTvState: state.listTvState,
        statusMessage: state.statusMessage,
        index: state.index,
        status: state.status,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<RatedTvState> emit) async {}

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<RatedTvState> emit) async {
    emit(RatedTvInitial(
      listRated: state.listRated,
      listTvState: state.listTvState,
      status: state.status,
      sortBy: state.sortBy,
      index: state.index,
      statusMessage: state.statusMessage,
    ));
  }
}
