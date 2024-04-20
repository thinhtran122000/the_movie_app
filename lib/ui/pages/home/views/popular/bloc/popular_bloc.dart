import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/rest_api_client/index.dart';
import 'package:tmdb/utils/utils.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  CarouselController controller = CarouselController();
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  PopularBloc()
      : super(PopularInitial(
          listPopular: [],
          selectedIndex: 0,
          autoPlay: true,
        )) {
    on<SlidePageView>(_onSlidePageView);
    on<FetchData>(_onFetchData);
    on<AutoSlide>(_onAutoSlide);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<PopularState> emit) async {
    try {
      var result = await homeRepository.getPopularMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      emit(PopularSuccess(
        listPopular: result.list,
        selectedIndex: state.selectedIndex,
        autoPlay: state.autoPlay,
      ));
    } catch (e) {
      emit(PopularError(
        errorMessage: e.toString(),
        listPopular: state.listPopular,
        selectedIndex: state.selectedIndex,
        autoPlay: state.autoPlay,
      ));
    }
  }

  FutureOr<void> _onSlidePageView(SlidePageView event, Emitter<PopularState> emit) {
    try {
      emit(PopularSuccess(
        listPopular: state.listPopular,
        selectedIndex: event.selectedIndex,
        autoPlay: state.autoPlay,
      ));
    } catch (e) {
      emit(PopularError(
        errorMessage: e.toString(),
        listPopular: state.listPopular,
        selectedIndex: state.selectedIndex,
        autoPlay: state.autoPlay,
      ));
    }
  }

  FutureOr<void> _onAutoSlide(AutoSlide event, Emitter<PopularState> emit) {
    try {
      emit(PopularSuccess(
        listPopular: state.listPopular,
        selectedIndex: state.selectedIndex,
        autoPlay: event.autoPlay,
      ));
    } catch (e) {
      emit(PopularError(
        errorMessage: e.toString(),
        listPopular: state.listPopular,
        selectedIndex: state.selectedIndex,
        autoPlay: state.autoPlay,
      ));
    }
  }
}
