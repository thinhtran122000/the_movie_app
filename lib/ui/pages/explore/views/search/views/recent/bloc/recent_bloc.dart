import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int page = 1;
  RecentBloc()
      : super(RecentInitial(
          query: '',
          listSearch: [],
          listTrending: [],
          visible: false,
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<RecentState> emit) async {
    try {
      if (event.isSearching) {
        emit(RecentLoading(
          listSearch: state.listSearch,
          query: state.query,
          listTrending: state.listTrending,
          visible: state.visible,
        ));
      }
      page = 1;
      final searchResult = await exploreRepository.getsearchMultiple(
        query: event.query,
        includeAdult: event.includeAdult,
        language: event.language,
        page: page,
      );
      if (searchResult.list.isNotEmpty) {
        page++;
        emit(RecentSuccess(
          listSearch: searchResult.list,
          query: event.query,
          listTrending: state.listTrending,
          visible: false,
        ));
      } else {
        page = 1;
        final trendingResult = await homeRepository.getTrendingMultiple(
          mediaType: event.mediaType,
          timeWindow: event.timeWindow,
          page: page,
          language: event.language,
          includeAdult: event.includeAdult,
        );
        if (trendingResult.list.isNotEmpty) {
          state.listSearch.clear();
          page++;
          emit(RecentSuccess(
            listSearch: state.listSearch,
            query: event.query,
            listTrending: trendingResult.list,
            visible: state.visible,
          ));
        } else {
          emit(RecentSuccess(
            listSearch: state.listSearch,
            query: event.query,
            listTrending: state.listTrending,
            visible: state.visible,
          ));
        }
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      state.listSearch.clear();
      state.listTrending.clear();
      emit(RecentError(
        errorMessage: e.toString(),
        listSearch: state.listSearch,
        listTrending: state.listTrending,
        query: state.query,
        visible: state.visible,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<RecentState> emit) async {
    try {
      refreshController.requestLoading();
      if (page > 1000) {
        refreshController.loadNoData();
        return;
      }
      var currentSearchList = (state as RecentSuccess).listSearch;
      if (currentSearchList.isNotEmpty) {
        final searchResult = await exploreRepository.getsearchMultiple(
          query: event.query,
          includeAdult: event.includeAdult,
          language: event.language,
          page: page,
        );
        if (searchResult.list.isEmpty) {
          refreshController.loadNoData();
        } else {
          page++;
          var newList = List<MultipleMedia>.from(currentSearchList)..addAll(searchResult.list);
          emit(RecentSuccess(
            listSearch: newList,
            listTrending: state.listTrending,
            query: event.query,
            visible: state.visible,
          ));
          refreshController.loadComplete();
        }
      } else {
        var currentTrendingList = (state as RecentSuccess).listTrending;
        final trendingResult = await homeRepository.getTrendingMultiple(
          mediaType: event.mediaType,
          timeWindow: event.timeWindow,
          page: page,
          language: event.language,
          includeAdult: event.includeAdult,
        );
        if (trendingResult.list.isEmpty) {
          refreshController.loadNoData();
        } else {
          page++;
          var newList = List<MultipleMedia>.from(currentTrendingList)..addAll(trendingResult.list);
          emit(RecentSuccess(
            listSearch: state.listSearch,
            listTrending: newList,
            query: state.query,
            visible: state.visible,
          ));
          refreshController.loadComplete();
        }
      }
    } catch (e) {
      refreshController.loadFailed();
      state.listSearch.clear();
      state.listTrending.clear();
      emit(RecentError(
        errorMessage: e.toString(),
        listSearch: state.listSearch,
        listTrending: state.listTrending,
        query: state.query,
        visible: false,
      ));
    }
  }
}
