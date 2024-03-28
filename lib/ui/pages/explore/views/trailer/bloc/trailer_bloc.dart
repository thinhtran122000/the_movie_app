// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:movie_app/models/models.dart';
// import 'package:movie_app/ui/pages/explore/explore_repository.dart';
// import 'package:movie_app/utils/utils.dart';

// part 'trailer_event.dart';
// part 'trailer_state.dart';

// class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
//   final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
//   final PageController movieController = PageController();
//   final PageController tvController = PageController();
//   TrailerBloc()
//       : super(TrailerInitial(
//           indexMovie: 0,
//           indexTv: 0,
//           listMovie: [],
//           listTv: [],
//           isActive: false,
//           listTrailerMovie: [],
//           listTrailerTv: [],
//           visibleVideoMovie: List.filled(20, false),
//           visibleVideoTv: List.filled(20, false),
//         )) {
//     on<FetchData>(_onFetchData);
//     on<ChangeType>(_onChangeType);
//     on<PlayTrailer>(_onPlayTrailer);
//     on<StopTrailer>(_onStopTrailer);
//   }

//   FutureOr<void> _onFetchData(FetchData event, Emitter<TrailerState> emit) async {
//     try {
//       final resultMovie = await exploreRepository.getNowPlayingMovie(
//         language: event.language,
//         page: event.page,
//         region: event.region,
//       );

//       final resultTv = await exploreRepository.getNowPlayingTv(
//         language: event.language,
//         page: event.page,
//       );
//       // call API trailer movie
//       final listTrailersMovie = await Future.wait(resultMovie.list.map<Future<List<MediaTrailer>>>(
//         (e) async {
//           final resultsTrailerMovie = await exploreRepository.getTrailerMovie(
//             movieId: e.id ?? 0,
//             language: event.language,
//           );
//           return resultsTrailerMovie.list.isEmpty ? [] : resultsTrailerMovie.list;
//         },
//       ).toList());
//       final listTrailerMovie = listTrailersMovie
//           .map<MediaTrailer>(
//             (e) => e.isNotEmpty
//                 ? e.firstWhere(
//                     (element) => (element.type ?? '').contains('Trailer'),
//                     orElse: () => MediaTrailer(key: ''),
//                   )
//                 : MediaTrailer(key: ''),
//           )
//           .toList();
//       // call API trailer tv
//       final listOfListTrailerTv = await Future.wait(resultTv.list.map<Future<List<MediaTrailer>>>(
//         (e) async {
//           final resultsTrailerTv = await exploreRepository.getTrailerTv(
//             seriesId: e.id ?? 0,
//             language: event.language,
//           );
//           return resultsTrailerTv.list.isEmpty ? [] : resultsTrailerTv.list;
//         },
//       ).toList());
//       final listTrailerTv = listOfListTrailerTv
//           .map<MediaTrailer>(
//             (e) => e.isNotEmpty ? e.first : MediaTrailer(key: ''),
//           )
//           .toList();
//       emit(TrailerSuccess(
//         indexTv: state.indexTv,
//         indexMovie: state.indexMovie,
//         listMovie: resultMovie.list,
//         listTv: resultTv.list,
//         listTrailerMovie: listTrailerMovie,
//         listTrailerTv: listTrailerTv,
//         isActive: state.isActive,
//         visibleVideoMovie: state.visibleVideoMovie,
//         visibleVideoTv: state.visibleVideoTv,
//       ));
//     } catch (e) {
//       emit(TrailerError(
//         indexTv: state.indexTv,
//         indexMovie: state.indexMovie,
//         errorMessage: e.toString(),
//         listMovie: state.listMovie,
//         listTv: state.listTv,
//         listTrailerMovie: state.listTrailerMovie,
//         listTrailerTv: state.listTrailerTv,
//         isActive: state.isActive,
//         visibleVideoMovie: state.visibleVideoMovie,
//         visibleVideoTv: state.visibleVideoTv,
//       ));
//     }
//   }

//   FutureOr<void> _onChangeType(ChangeType event, Emitter<TrailerState> emit) {
//     try {
//       emit(TrailerSuccess(
//         indexMovie: state.indexMovie,
//         indexTv: state.indexTv,
//         listMovie: state.listMovie,
//         listTv: state.listTv,
//         listTrailerMovie: state.listTrailerMovie,
//         listTrailerTv: state.listTrailerTv,
//         isActive: event.isActive,
//         visibleVideoMovie: List.filled(20, false),
//         visibleVideoTv: List.filled(20, false),
//       ));
//     } catch (e) {
//       emit(TrailerError(
//         errorMessage: e.toString(),
//         indexMovie: state.indexMovie,
//         indexTv: state.indexTv,
//         listMovie: state.listMovie,
//         listTv: state.listTv,
//         listTrailerMovie: state.listTrailerMovie,
//         listTrailerTv: state.listTrailerTv,
//         isActive: state.isActive,
//         visibleVideoMovie: state.visibleVideoMovie,
//         visibleVideoTv: state.visibleVideoTv,
//       ));
//     }
//   }

//   FutureOr<void> _onPlayTrailer(PlayTrailer event, Emitter<TrailerState> emit) {
//     try {
//       if (event.isActive) {
//         event.visibleVideoTv[event.indexTv ?? 0] = !event.visibleVideoTv[event.indexTv ?? 0];
//       } else {
//         event.visibleVideoMovie[event.indexMovie ?? 0] =
//             !event.visibleVideoMovie[event.indexMovie ?? 0];
//       }
//       emit(TrailerSuccess(
//         indexMovie: event.indexMovie ?? 0,
//         indexTv: event.indexTv ?? 0,
//         listMovie: state.listMovie,
//         listTv: state.listTv,
//         listTrailerMovie: state.listTrailerMovie,
//         listTrailerTv: state.listTrailerTv,
//         isActive: state.isActive,
//         visibleVideoMovie: event.visibleVideoMovie,
//         visibleVideoTv: event.visibleVideoTv,
//       ));
//     } catch (e) {
//       emit(TrailerError(
//         errorMessage: e.toString(),
//         indexMovie: state.indexMovie,
//         indexTv: state.indexTv,
//         listMovie: state.listMovie,
//         listTv: state.listTv,
//         listTrailerMovie: state.listTrailerMovie,
//         listTrailerTv: state.listTrailerTv,
//         isActive: state.isActive,
//         visibleVideoMovie: state.visibleVideoMovie,
//         visibleVideoTv: state.visibleVideoTv,
//       ));
//     }
//   }

//   FutureOr<void> _onStopTrailer(StopTrailer event, Emitter<TrailerState> emit) {
//     try {
//       if (state is TrailerError) {
//         emit(TrailerError(
//           errorMessage: (state as TrailerError).errorMessage,
//           indexMovie: state.indexMovie,
//           indexTv: state.indexTv,
//           listMovie: state.listMovie,
//           listTv: state.listTv,
//           listTrailerMovie: state.listTrailerMovie,
//           listTrailerTv: state.listTrailerTv,
//           isActive: state.isActive,
//           visibleVideoMovie: state.visibleVideoMovie,
//           visibleVideoTv: state.visibleVideoTv,
//         ));
//       } else {
//         if (event.isActive) {
//           event.visibleVideoTv[event.indexTv ?? 0] = false;
//         } else {
//           event.visibleVideoMovie[event.indexMovie ?? 0] = false;
//         }
//         emit(TrailerSuccess(
//           listMovie: state.listMovie,
//           indexTv: state.indexTv,
//           indexMovie: state.indexMovie,
//           listTv: state.listTv,
//           listTrailerMovie: state.listTrailerMovie,
//           listTrailerTv: state.listTrailerTv,
//           isActive: state.isActive,
//           visibleVideoMovie: event.visibleVideoMovie,
//           visibleVideoTv: event.visibleVideoTv,
//         ));
//       }
//     } catch (e) {
//       emit(TrailerError(
//         errorMessage: e.toString(),
//         indexMovie: state.indexMovie,
//         indexTv: state.indexTv,
//         listMovie: state.listMovie,
//         listTv: state.listTv,
//         listTrailerMovie: state.listTrailerMovie,
//         listTrailerTv: state.listTrailerTv,
//         isActive: state.isActive,
//         visibleVideoMovie: state.visibleVideoMovie,
//         visibleVideoTv: state.visibleVideoTv,
//       ));
//     }
//   }

//   @override
//   Future<void> close() {
//     movieController.dispose();
//     tvController.dispose();
//     return super.close();
//   }
// }
