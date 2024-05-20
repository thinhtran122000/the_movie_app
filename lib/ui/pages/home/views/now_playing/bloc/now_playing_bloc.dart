import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/pages/details/details.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';
import 'package:tmdb/utils/utils.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  final DetailsRepository detailsRepository = DetailsRepository(restApiClient: RestApiClient());

  NowPlayingBloc()
      : super(NowPlayingInitial(
          nowPlayingTv: MultipleDetails(),
          paletteColors: [],
          averageLuminance: 0,
          mediaState: null,
          statusMessage: '',
        )) {
    on<FetchDataNowPlaying>(_onFetchDataNowPlaying);
    on<AddFavorites>(_onAddFavorites);
  }

  FutureOr<void> _onFetchDataNowPlaying(
      FetchDataNowPlaying event, Emitter<NowPlayingState> emit) async {
    try {
      final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      if (event.fetchFeature) {
        final result = await homeRepository.getNowPlayingTv(
          language: event.language,
          page: event.page,
        );
        final randomNowPlaying = (result.list..shuffle()).first;
        final resultDetails = await detailsRepository.getDetailsTv(
          language: event.language,
          tvId: randomNowPlaying.id ?? 0,
          appendToResponse: null,
        );
        if ((resultDetails.object.posterPath ?? '').isNotEmpty) {
          final baseUrl = await compute(
              Uri.parse, '${AppConstants.kImagePathPoster}${resultDetails.object.posterPath}');
          final loadImage = resultDetails.object.posterPath != null
              ? await compute(NetworkAssetBundle(baseUrl).load,
                  '${AppConstants.kImagePathPoster}${resultDetails.object.posterPath}') // Parse Image --> ByteData
              : await rootBundle.load(ImagesPath.noImage.assetName);
          final imageBytes =
              loadImage.buffer.asUint8List(); // Parse ByteData --> Uint8List (matrix)
          final colors =
              await AppUtils().extractColors(imageBytes); // Extract the colors from matrix
          final paletteColors = await AppUtils().generatePalette(
            {'palette': colors, 'numberOfItemsPixel': 16},
          ); // Get pallete colors
          final paletteRemoveWhite = resultDetails.object.posterPath != null
              ? (paletteColors
                ..removeWhere(
                  (element) => element.computeLuminance() > 0.8,
                )) // Remove color which have luminance > 0.8 (reduce white color)
              : paletteColors;
          final averageLuminance = await AppUtils().getLuminance(paletteColors);
          if (accessToken == null) {
            emit(NowPlayingSuccess(
              nowPlayingTv: resultDetails.object,
              mediaState: null,
              statusMessage: state.statusMessage,
              averageLuminance: averageLuminance,
              paletteColors: paletteRemoveWhite,
            ));
          } else {
            final stateResult = await detailsRepository.getTvState(
              seriesId: resultDetails.object.id ?? 0,
              sessionId: sessionId,
            );
            emit(NowPlayingSuccess(
              nowPlayingTv: resultDetails.object,
              mediaState: stateResult.object,
              statusMessage: state.statusMessage,
              averageLuminance: averageLuminance,
              paletteColors: paletteRemoveWhite,
            ));
          }
        } else {
          return;
        }
      } else {
        final stateResult = await detailsRepository.getTvState(
          seriesId: state.nowPlayingTv.id ?? 0,
          sessionId: sessionId,
        );
        emit(NowPlayingSuccess(
          nowPlayingTv: state.nowPlayingTv,
          mediaState: stateResult.object,
          statusMessage: state.statusMessage,
          averageLuminance: state.averageLuminance,
          paletteColors: state.paletteColors,
        ));
      }
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
        paletteColors: state.paletteColors,
        averageLuminance: state.averageLuminance,
        mediaState: state.mediaState,
        statusMessage: state.statusMessage,
      ));
    }
  }

  FutureOr<void> _onAddFavorites(AddFavorites event, Emitter<NowPlayingState> emit) async {
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
      emit(NowPlayingAddFavoritesSuccess(
        nowPlayingTv: state.nowPlayingTv,
        mediaState: state.mediaState,
        statusMessage: result.object.statusMessage ?? '',
        averageLuminance: state.averageLuminance,
        paletteColors: state.paletteColors,
      ));
    } catch (e) {
      emit(NowPlayingAddFavoritesError(
        errorMessage: e.toString(),
        mediaState: state.mediaState,
        nowPlayingTv: state.nowPlayingTv,
        statusMessage: state.statusMessage,
        averageLuminance: state.averageLuminance,
        paletteColors: state.paletteColors,
      ));
    }
  }
}


// final colors = AppUtils().extractPixelsColors(imageBytes);
// final paletteColors = AppUtils().generatePalette({'palette': colors, 'numberOfItems': 16});
// final averageLuminance = AppUtils().getLuminance(paletteColors);