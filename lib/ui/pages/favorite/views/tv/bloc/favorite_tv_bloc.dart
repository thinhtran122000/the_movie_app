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
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<Sort>(_onSort);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<FavoriteTvState> emit) async {
    try {
      page = 1;
      final result = await favoriteRepository.getFavoriteTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      if (result.list.isNotEmpty) {
        page++;
        emit(FavoriteTvSuccess(
          listFavorite: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
        ));
      } else {
        emit(FavoriteTvSuccess(
          listFavorite: result.list,
          status: state.status,
          sortBy: event.sortBy ?? '',
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
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<FavoriteTvState> emit) async {
    try {
      controller.requestLoading();
      final result = await favoriteRepository.getFavoriteTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      var curentList = (state as FavoriteTvSuccess).listFavorite;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        var newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        emit(FavoriteTvSuccess(
          listFavorite: newList,
          status: state.status,
          sortBy: state.sortBy,
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
      ));
    }
  }

  FutureOr<void> _onSort(Sort event, Emitter<FavoriteTvState> emit) {
    state.status
        ? emit(FavoriteTvSortSuccess(
            listFavorite: state.listFavorite,
            status: event.status,
            sortBy: 'created_at.asc',
          ))
        : emit(FavoriteTvSortSuccess(
            listFavorite: state.listFavorite,
            status: event.status,
            sortBy: 'created_at.desc',
          ));
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<FavoriteTvState> emit) {
    emit(FavoriteTvInitial(
      listFavorite: state.listFavorite,
      status: state.status,
      sortBy: state.sortBy,
    ));
  }
}
