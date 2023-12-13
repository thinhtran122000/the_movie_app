import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';

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
        )) {
    on<FetchData>(_onFetchData);
    on<ChangeColor>(_onChangeColor);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<NowPlayingState> emit) async {
    try {
      var result = await homeRepository.getNowPlayingTv(
        language: event.language,
        page: event.page,
      );
      var randomNowPlaying = (result.list..shuffle()).first;
      var resultDetails = await detailsRepository.getDetailsTv(
        language: event.language,
        tvId: randomNowPlaying.id ?? 0,
        appendToResponse: null,
      );
      emit(NowPlayingSuccess(
        nowPlayingTv: resultDetails.object,
        paletteColors: [],
        averageLuminance: state.averageLuminance,
      ));
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
        paletteColors: state.paletteColors,
        averageLuminance: state.averageLuminance,
      ));
    }
  }

  FutureOr<void> _onChangeColor(ChangeColor event, Emitter<NowPlayingState> emit) async {
    try {
      if (event.posterPath.isNotEmpty) {
        final baseUrl = await compute(Uri.parse, event.posterPath);
        final loadImage = state.nowPlayingTv.posterPath != null
            ? await compute(
                NetworkAssetBundle(baseUrl).load, event.posterPath) // Parse Image --> ByteData
            : await rootBundle.load(event.posterPath);
        final imageBytes = loadImage.buffer.asUint8List(); // Parse ByteData --> Uint8List (matrix)
        final colors = await AppUtils().extractColors(imageBytes); // Extract the colors from matrix
        final paletteColors = await AppUtils().generatePalette(
          {'palette': colors, 'numberOfItemsPixel': 16},
        ); // Get pallete colors
        final paletteRemoveWhite = state.nowPlayingTv.posterPath != null
            ? (paletteColors
              ..removeWhere((element) =>
                  element.computeLuminance() >
                  0.8)) // Remove color which have luminance > 0.8 (reduce white color)
            : paletteColors;
        final averageLuminance = await AppUtils().getLuminance(paletteColors);
        emit(NowPlayingSuccess(
          averageLuminance: averageLuminance,
          paletteColors: paletteRemoveWhite,
          nowPlayingTv: state.nowPlayingTv,
        ));
      } else {
        return;
      }
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
        paletteColors: state.paletteColors,
        averageLuminance: state.averageLuminance,
      ));
    }
  }
}


// final colors = AppUtils().extractPixelsColors(imageBytes);
// final paletteColors = AppUtils().generatePalette({'palette': colors, 'numberOfItems': 16});
// final averageLuminance = AppUtils().getLuminance(paletteColors);