import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tmdb/ui/pages/pages.dart';
import 'package:tmdb/utils/utils.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingRepository ratingRepository = RatingRepository(restApiClient: RestApiClient());
  RatingBloc()
      : super(RatingInitial(
          value: 0,
        )) {
    on<FetchDataRating>(_onFetchData);
    on<AddRating>(_onAddRating);
    on<RemoveRating>(_onRemoveRating);
  }
  FutureOr<void> _onFetchData(FetchDataRating event, Emitter<RatingState> emit) async {
    try {
      emit(RatingLoaded(
        value: event.value,
      ));
    } catch (e) {
      emit(RatingError(
        errorMessage: e.toString(),
        value: state.value,
      ));
    }
  }

  FutureOr<void> _onAddRating(AddRating event, Emitter<RatingState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      if (event.mediaType == MediaType.movie) {
        final result = await ratingRepository.addRatingMovie(
          movieId: event.id,
          sessionId: sessionId,
          value: event.value,
        );
        if (result.object.success == true) {
          emit(RatingSuccess(
            value: state.value,
          ));
        } else {
          emit(RatingError(
            errorMessage: 'Error',
            value: state.value,
          ));
        }
      } else {
        final result = await ratingRepository.addRatingTv(
          seriesId: event.id,
          sessionId: sessionId,
          value: event.value,
        );
        if (result.object.success == true) {
          emit(RatingSuccess(
            value: state.value,
          ));
        } else {
          emit(RatingError(
            errorMessage: 'Error',
            value: state.value,
          ));
        }
      }
    } catch (e) {
      emit(RatingError(
        errorMessage: e.toString(),
        value: state.value,
      ));
    }
  }

  FutureOr<void> _onRemoveRating(RemoveRating event, Emitter<RatingState> emit) async {
    try {
      final sessionId = await FlutterStorage().getValue(AppKeys.sessionIdKey) ?? '';
      if (event.mediaType == MediaType.movie) {
        final result = await ratingRepository.deleteRatingMovie(
          movieId: event.id,
          sessionId: sessionId,
        );
        if (result.object.success == true) {
          emit(RatingSuccess(
            value: state.value,
          ));
        } else {
          emit(RatingError(
            errorMessage: 'Error delete rating movie',
            value: state.value,
          ));
        }
      } else {
        final result = await ratingRepository.deleteRatingTv(
          seriesId: event.id,
          sessionId: sessionId,
        );
        if (result.object.success == true) {
          emit(RatingSuccess(
            value: state.value,
          ));
        } else {
          emit(RatingError(
            errorMessage: 'Error delete rating tv',
            value: state.value,
          ));
        }
      }
    } catch (e) {
      emit(RatingError(
        errorMessage: e.toString(),
        value: state.value,
      ));
    }
  }
}
