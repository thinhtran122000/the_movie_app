// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_app/models/models.dart';
// import 'package:movie_app/ui/pages/home/home_repository.dart';
// import 'package:movie_app/ui/pages/search/search.dart';
// import 'package:movie_app/utils/utils.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// part 'search_event.dart';
// part 'search_state.dart';

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   SearchRepository searchRepository = SearchRepository(restApiClient: RestApiClient());
//   HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
//   RefreshController refreshController = RefreshController();
//   TextEditingController textController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//   int page = 1;
//   SearchBloc()
//       : super(SearchInitial(
//           query: '',
//           listSearch: [],
//           listTrending: [],
//           visible: false,
//         )) {
//     on<FetchData>(_onFetchData);
//     on<LoadMore>(_onLoadMore);
//     on<ShowHideButton>(_onShowHideButton);
//     on<LoadShimmer>(_onLoadShimmer);
//   }

//   FutureOr<void> _onFetchData(FetchData event, Emitter<SearchState> emit) async {
//     try {
//       page = 1;
//       final searchResult = await searchRepository.getsearchMultiple(
//         query: event.query,
//         includeAdult: event.includeAdult,
//         language: event.language,
//         page: page,
//       );
//       if (searchResult.list.isNotEmpty) {
//         page++;
//         emit(SearchSuccess(
//           listSearch: searchResult.list,
//           query: event.query,
//           listTrending: state.listTrending,
//           visible: state.visible,
//         ));
//       } else {
//         page = 1;
//         final trendingResult = await homeRepository.getTrendingMultiple(
//           mediaType: event.mediaType,
//           timeWindow: event.timeWindow,
//           page: page,
//           language: event.language,
//           includeAdult: event.includeAdult,
//         );
//         if (trendingResult.list.isNotEmpty) {
//           state.listSearch.clear();
//           page++;
//           emit(SearchSuccess(
//             listSearch: state.listSearch,
//             query: event.query,
//             listTrending: trendingResult.list,
//             visible: state.visible,
//           ));
//         } else {
//           emit(SearchSuccess(
//             listSearch: state.listSearch,
//             query: event.query,
//             listTrending: state.listTrending,
//             visible: state.visible,
//           ));
//         }
//       }
//       refreshController.loadComplete();
//       refreshController.refreshCompleted();
//     } catch (e) {
//       refreshController.refreshFailed();
//       state.listSearch.clear();
//       state.listTrending.clear();
//       emit(SearchError(
//         errorMessage: e.toString(),
//         listSearch: state.listSearch,
//         listTrending: state.listTrending,
//         query: state.query,
//         visible: state.visible,
//       ));
//     }
//   }

//   FutureOr<void> _onLoadMore(LoadMore event, Emitter<SearchState> emit) async {
//     try {
//       refreshController.requestLoading();
//       if (page > 1000) {
//         refreshController.loadNoData();
//         return;
//       }
//       var currentSearchList = (state as SearchSuccess).listSearch;
//       if (currentSearchList.isNotEmpty) {
//         final searchResult = await searchRepository.getsearchMultiple(
//           query: event.query,
//           includeAdult: event.includeAdult,
//           language: event.language,
//           page: page,
//         );
//         if (searchResult.list.isEmpty) {
//           refreshController.loadNoData();
//         } else {
//           page++;
//           var newList = List<MultipleMedia>.from(currentSearchList)..addAll(searchResult.list);
//           emit(SearchSuccess(
//             listSearch: newList,
//             listTrending: state.listTrending,
//             query: event.query,
//             visible: state.visible,
//           ));
//           refreshController.loadComplete();
//         }
//       } else {
//         var currentTrendingList = (state as SearchSuccess).listTrending;
//         final trendingResult = await homeRepository.getTrendingMultiple(
//           mediaType: event.mediaType,
//           timeWindow: event.timeWindow,
//           page: page,
//           language: event.language,
//           includeAdult: event.includeAdult,
//         );
//         if (trendingResult.list.isEmpty) {
//           refreshController.loadNoData();
//         } else {
//           page++;
//           var newList = List<MultipleMedia>.from(currentTrendingList)..addAll(trendingResult.list);
//           emit(SearchSuccess(
//             listSearch: state.listSearch,
//             listTrending: newList,
//             query: state.query,
//             visible: state.visible,
//           ));
//           refreshController.loadComplete();
//         }
//       }
//     } catch (e) {
//       refreshController.loadFailed();
//       state.listSearch.clear();
//       state.listTrending.clear();
//       emit(SearchError(
//         errorMessage: e.toString(),
//         listSearch: state.listSearch,
//         listTrending: state.listTrending,
//         query: state.query,
//         visible: false,
//       ));
//     }
//   }

//   FutureOr<void> _onShowHideButton(ShowHideButton event, Emitter<SearchState> emit) {
//     if (state.listTrending.isNotEmpty || state.listSearch.isNotEmpty) {
//       emit(SearchSuccess(
//         listSearch: state.listSearch,
//         listTrending: state.listTrending,
//         query: state.query,
//         visible: event.visible,
//       ));
//     } else {
//       emit(SearchError(
//         errorMessage: 'An unexpected error occurred.',
//         listSearch: state.listSearch,
//         listTrending: state.listTrending,
//         query: state.query,
//         visible: state.visible,
//       ));
//     }
//   }

//   FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<SearchState> emit) {
//     emit(SearchInitial(
//       query: '',
//       listSearch: [],
//       listTrending: [],
//       visible: false,
//     ));
//   }
// }
