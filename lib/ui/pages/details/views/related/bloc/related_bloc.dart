import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/details/details.dart';
import 'package:tmdb/utils/utils.dart';

part 'related_event.dart';
part 'related_state.dart';

class RelatedBloc extends Bloc<RelatedEvent, RelatedState> {
  final DetailsRepository detailsRepository = DetailsRepository(restApiClient: RestApiClient());

  RelatedBloc()
      : super(RelatedInitial(
          statusMessage: '',
          index: 0,
          listRelated: [],
          listState: [],
        )) {
    on<FetchDataRelated>(_onFetchDataRelated);
    on<AddWatchList>(_onAddWatchList);
  }

  FutureOr<void> _onFetchDataRelated(FetchDataRelated event, Emitter<RelatedState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      if (event.mediaType == MediaType.movie) {
        final result = await detailsRepository.getMovieRelated(
          movieId: event.id,
          language: event.language,
          page: event.page,
        );
        if (accessToken == null) {
          emit(RelatedSuccess(
            listRelated: result.list,
            listState: [],
            statusMessage: state.statusMessage,
            index: state.index,
          ));
        } else {
          final listState = await Future.wait(result.list.map<Future<MediaState>>(
            (e) async {
              final stateResult = await detailsRepository.getMovieState(
                movieId: e.id ?? 0,
                sessionId: sessionId,
              );
              return stateResult.object;
            },
          ).toList());
          emit(RelatedSuccess(
            listRelated: result.list,
            listState: listState,
            statusMessage: state.statusMessage,
            index: state.index,
          ));
        }
      } else {
        final result = await detailsRepository.getTvRelated(
          seriesId: event.id,
          language: event.language,
          page: event.page,
        );
        if (accessToken == null) {
          emit(RelatedSuccess(
            listRelated: result.list,
            listState: [],
            statusMessage: state.statusMessage,
            index: state.index,
          ));
        } else {
          final listState = await Future.wait(result.list.map<Future<MediaState>>(
            (e) async {
              final stateResult = await detailsRepository.getTvState(
                seriesId: e.id ?? 0,
                sessionId: sessionId,
              );
              return stateResult.object;
            },
          ).toList());
          emit(RelatedSuccess(
            listRelated: result.list,
            listState: listState,
            statusMessage: state.statusMessage,
            index: state.index,
          ));
        }
      }
    } catch (e) {
      emit(RelatedError(
        errorMessage: e.toString(),
        listRelated: state.listRelated,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddWatchList(AddWatchList event, Emitter<RelatedState> emit) async {
    try {
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      state.listState[event.index].watchlist = !(state.listState[event.index].watchlist ?? false);
      final result = await detailsRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.listState[event.index].watchlist ?? false,
      );
      emit(RelatedAddWatchlistSuccess(
        listRelated: state.listRelated,
        listState: state.listState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(RelatedError(
        errorMessage: e.toString(),
        listRelated: state.listRelated,
        listState: state.listState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }
}
