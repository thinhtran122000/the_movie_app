import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  CarouselController controller = CarouselController();
  UpcomingBloc() : super(UpcomingInitial(listUpcoming: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<UpcomingState> emit) async {
    try {
      var result = await homeRepository.getUpcomingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      emit(UpcomingSuccess(listUpcoming: result.list));
    } catch (e) {
      emit(UpcomingError(
        errorMessage: e.toString(),
        listUpcoming: state.listUpcoming,
      ));
    }
  }
}
