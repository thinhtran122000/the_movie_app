import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/details/details.dart';
import 'package:tmdb/utils/utils.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository detailsRepository = DetailsRepository(restApiClient: RestApiClient());
  DetailsBloc()
      : super(DetailsInitial(
          multipleDetails: MultipleDetails(),
          mediaState: MediaState(),
          images: [],
          statusMessage: '',
          cast: [],
          crew: [],
        )) {
    on<FetchDataDetails>(_onFetchDataDetails);
    on<FetchFeature>(_onFetchFeature);
    on<FetchState>(_onFetchState);
    on<FetchCredits>(_onFetchCredits);
    on<AddFavorites>(_onAddFavorites);
    on<AddWatchlist>(_onAddWatchlist);
  }
  FutureOr<void> _onFetchDataDetails(FetchDataDetails event, Emitter<DetailsState> emit) {
    add(FetchFeature(
      id: event.id,
      mediaType: event.mediaType,
      language: event.language,
    ));
    add(FetchState(
      id: event.id,
      mediaType: event.mediaType,
    ));
    add(FetchCredits(
      id: event.id,
      mediaType: event.mediaType,
      language: event.language,
    ));
  }

  FutureOr<void> _onFetchFeature(FetchFeature event, Emitter<DetailsState> emit) async {
    try {
      if (event.mediaType == MediaType.movie) {
        final detailsResult = await detailsRepository.getDetailsMovie(
          language: event.language,
          movieId: event.id,
          appendToResponse: 'similar',
        );
        final imagesResult = await detailsRepository.getImagesMovie(
          language: event.language,
          movieId: event.id,
          includeImageLanguage: 'null',
        );
        emit(DetailsLoaded(
          multipleDetails: detailsResult.object,
          images: imagesResult.object.backdrops,
          mediaState: state.mediaState,
          statusMessage: state.statusMessage,
          cast: state.cast,
          crew: state.crew,
        ));
      } else {
        final detailsResult = await detailsRepository.getDetailsTv(
          language: event.language,
          tvId: event.id,
          appendToResponse: 'similar',
        );
        final imagesResult = await detailsRepository.getImagesTv(
          language: event.language,
          seriesId: event.id,
          includeImageLanguage: 'null',
        );
        emit(DetailsLoaded(
          multipleDetails: detailsResult.object,
          images: imagesResult.object.backdrops,
          mediaState: state.mediaState,
          statusMessage: state.statusMessage,
          cast: state.cast,
          crew: state.crew,
        ));
      }
    } catch (e) {
      emit(DetailsError(
        errorMessage: e.toString(),
        multipleDetails: state.multipleDetails,
        images: state.images,
        mediaState: state.mediaState,
        statusMessage: state.statusMessage,
        cast: state.cast,
        crew: state.crew,
      ));
    }
  }

  FutureOr<void> _onFetchState(FetchState event, Emitter<DetailsState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      if (accessToken == null) {
        emit(DetailsLoaded(
          multipleDetails: state.multipleDetails,
          images: state.images,
          mediaState: null,
          statusMessage: state.statusMessage,
          cast: state.cast,
          crew: state.crew,
        ));
      } else {
        if (event.mediaType == MediaType.movie) {
          final stateResult = await detailsRepository.getMovieState(
            movieId: event.id,
            sessionId: sessionId,
          );
          emit(DetailsLoaded(
            multipleDetails: state.multipleDetails,
            images: state.images,
            mediaState: stateResult.object,
            statusMessage: state.statusMessage,
            cast: state.cast,
            crew: state.crew,
          ));
        } else {
          final stateResult = await detailsRepository.getTvState(
            seriesId: event.id,
            sessionId: sessionId,
          );
          emit(DetailsLoaded(
            multipleDetails: state.multipleDetails,
            images: state.images,
            mediaState: stateResult.object,
            statusMessage: state.statusMessage,
            cast: state.cast,
            crew: state.crew,
          ));
        }
      }
    } catch (e) {
      emit(DetailsError(
        errorMessage: e.toString(),
        multipleDetails: state.multipleDetails,
        images: state.images,
        mediaState: state.mediaState,
        statusMessage: state.statusMessage,
        cast: state.cast,
        crew: state.crew,
      ));
    }
  }

  FutureOr<void> _onFetchCredits(FetchCredits event, Emitter<DetailsState> emit) async {
    try {
      if (event.mediaType == MediaType.movie) {
        final result = await detailsRepository.getMovieCredits(
          movieId: event.id,
          language: event.language,
        );
        emit(DetailsLoaded(
          multipleDetails: state.multipleDetails,
          mediaState: state.mediaState,
          images: state.images,
          statusMessage: state.statusMessage,
          cast: result.object.cast,
          crew: result.object.crew,
        ));
      } else {
        final result = await detailsRepository.getTvCredits(
          seriesId: event.id,
          language: event.language,
        );
        emit(DetailsLoaded(
          multipleDetails: state.multipleDetails,
          mediaState: state.mediaState,
          images: state.images,
          statusMessage: state.statusMessage,
          cast: result.object.cast,
          crew: result.object.crew,
        ));
      }
    } catch (e) {
      emit(DetailsError(
        errorMessage: e.toString(),
        multipleDetails: state.multipleDetails,
        images: state.images,
        mediaState: state.mediaState,
        statusMessage: state.statusMessage,
        cast: state.cast,
        crew: state.crew,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<DetailsState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      state.mediaState?.favorite = !(state.mediaState?.favorite ?? false);
      final result = await detailsRepository.addFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        favorite: state.mediaState?.favorite ?? false,
      );
      emit(DetailsAddFavoriteSuccess(
        multipleDetails: state.multipleDetails,
        images: state.images,
        mediaState: state.mediaState,
        statusMessage: result.object.statusMessage ?? '',
        cast: state.cast,
        crew: state.crew,
      ));
    } catch (e) {
      emit(DetailsError(
        errorMessage: e.toString(),
        images: state.images,
        mediaState: state.mediaState,
        multipleDetails: state.multipleDetails,
        statusMessage: state.statusMessage,
        cast: state.cast,
        crew: state.crew,
      ));
    }
  }

  FutureOr<void> _onAddWatchlist(AddWatchlist event, Emitter<DetailsState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      final accountId = int.parse(await FlutterStorage().getValue(AppKeys.accountIdKey) ?? '');
      state.mediaState?.watchlist = !(state.mediaState?.watchlist ?? false);

      final result = await detailsRepository.addWatchList(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: state.mediaState?.watchlist ?? false,
      );
      emit(DetailsAddWatchlistSuccess(
        multipleDetails: state.multipleDetails,
        images: state.images,
        mediaState: state.mediaState,
        statusMessage: result.object.statusMessage ?? '',
        cast: state.cast,
        crew: state.crew,
      ));
    } catch (e) {
      emit(DetailsError(
        errorMessage: e.toString(),
        images: state.images,
        mediaState: state.mediaState,
        multipleDetails: state.multipleDetails,
        statusMessage: state.statusMessage,
        cast: state.cast,
        crew: state.crew,
      ));
    }
  }
}
