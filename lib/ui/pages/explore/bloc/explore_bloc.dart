import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  ExploreBloc()
      : super(ExploreInitial(
          visible: false,
          opacity: 0.0,
          statusMessage: '',
          query: '',
        )) {
    on<ChangeAnimationToast>(_onChangeAnimationToast);
    on<DisplayToast>(_onDisplayToast);
    on<Search>(_onSearch);
    on<Clear>(_onClear);


  }

  FutureOr<void> _onChangeAnimationToast(ChangeAnimationToast event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      visible: state.visible,
      opacity: event.opacity,
      statusMessage: state.statusMessage,
      query: state.query,
    ));
  }

  FutureOr<void> _onDisplayToast(DisplayToast event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      opacity: state.opacity,
      visible: event.visible,
      statusMessage: event.statusMessage,
      query: state.query,
    ));
  }

  FutureOr<void> _onSearch(Search event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      opacity: state.opacity,
      visible: state.visible,
      statusMessage: state.statusMessage,
      query: event.query,
    ));
  }

  FutureOr<void> _onClear(Clear event, Emitter<ExploreState> emit) {
    textController.clear();
    emit(ExploreClearSuccess(
      opacity: state.opacity,
      visible: state.visible,
      statusMessage: state.statusMessage,
      query: textController.text,
    ));
  }
}
