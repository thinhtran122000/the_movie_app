import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/pages.dart';
import 'package:tmdb/utils/utils.dart';

part 'rated_movie_event.dart';
part 'rated_movie_state.dart';

class RatedMovieBloc extends Bloc<RatedMovieEvent, RatedMovieState> {
  RatedRepository ratedRepository = RatedRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  RatedMovieBloc()
      : super(RatedMovieInitial(
          listRated: [],
          listMovieState: [],
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

  FutureOr<void> _onFetchData(FetchData event, Emitter<RatedMovieState> emit) async {
    try {
      page = 1;
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await ratedRepository.getRatedMovie(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listMovieState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final movieStateResult = await ratedRepository.getMovieState(
            movieId: e.id ?? 0,
            sessionId: sessionId,
          );
          return movieStateResult.object;
        },
      ).toList());
      if (result.list.isNotEmpty) {
        page++;
        emit(RatedMovieSuccess(
          listMovieState: listMovieState,
          listRated: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
          index: state.index,
          statusMessage: state.statusMessage,
        ));
      } else {
        emit(RatedMovieSuccess(
          listRated: result.list,
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
      state.listRated.clear();
      emit(RatedMovieError(
        errorMessage: e.toString(),
        listRated: state.listRated,
        listMovieState: state.listMovieState,
        status: state.status,
        sortBy: event.sortBy ?? '',
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<RatedMovieState> emit) async {
    try {
      controller.requestLoading();
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final result = await ratedRepository.getRatedMovie(
        language: event.language,
        accountId: accountId,
        sessionId: sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      final listMovieState = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final movieStateResult = await ratedRepository.getMovieState(
            movieId: e.id ?? 0,
            sessionId: sessionId,
          );
          return movieStateResult.object;
        },
      ).toList());
      final curentList = (state as RatedMovieSuccess).listRated;
      final currentListMovieState = (state as RatedMovieSuccess).listMovieState;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        final newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        final newListMovieState = List<MediaState>.from(currentListMovieState)
          ..addAll(listMovieState);
        emit(RatedMovieSuccess(
          listMovieState: newListMovieState,
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
      emit(RatedMovieError(
        errorMessage: e.toString(),
        listRated: state.listRated,
        listMovieState: state.listMovieState,
        status: state.status,
        sortBy: state.sortBy,
        index: state.index,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<RatedMovieState> emit) async {
    state.status
        ? emit(RatedMovieSortSuccess(
            listRated: state.listRated,
            listMovieState: state.listMovieState,
            status: event.status,
            sortBy: 'created_at.asc',
            index: state.index,
            statusMessage: state.statusMessage,
          ))
        : emit(RatedMovieSortSuccess(
            listRated: state.listRated,
            listMovieState: state.listMovieState,
            status: event.status,
            sortBy: 'created_at.desc',
            index: state.index,
            statusMessage: state.statusMessage,
          ));
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<RatedMovieState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey);
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      state.listMovieState[event.index].watchlist =
          !(state.listMovieState[event.index].watchlist ?? false);
      final result = await ratedRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId ?? '',
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listMovieState[event.index].watchlist ?? false,
      );
      emit(RatedMovieAddWatchlistSuccess(
        listRated: state.listRated,
        listMovieState: state.listMovieState,
        statusMessage: result.object.statusMessage ?? '',
        sortBy: state.sortBy,
        status: state.status,
        index: event.index,
      ));
    } catch (e) {
      emit(RatedMovieError(
        errorMessage: e.toString(),
        listRated: state.listRated,
        listMovieState: state.listMovieState,
        statusMessage: state.statusMessage,
        index: state.index,
        status: state.status,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<RatedMovieState> emit) {
    emit(RatedMovieInitial(
      listRated: state.listRated,
      listMovieState: state.listMovieState,
      status: state.status,
      sortBy: state.sortBy,
      index: state.index,
      statusMessage: state.statusMessage,
    ));
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<RatedMovieState> emit) async {}
}
