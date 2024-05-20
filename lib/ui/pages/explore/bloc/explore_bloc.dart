import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  ExploreBloc()
      : super(ExploreInitial(
          indexViewExplore: 0,
          visible: false,
          opacity: 0.0,
          statusMessage: '',
          query: '',
          enabledSearch: false,
        )) {
    // on<ChangeAnimationToast>(_onChangeAnimationToast);
    // on<DisplayToast>(_onDisplayToast);
    on<NavigateViewExplore>(_onNavigateViewExplore);
    on<MoveToSearch>(_onMoveToSearch);
    on<Search>(_onSearch);
    on<Clear>(_onClear);
  }
  FutureOr<void> _onNavigateViewExplore(NavigateViewExplore event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      visible: state.visible,
      opacity: state.opacity,
      statusMessage: state.statusMessage,
      query: state.query,
      enabledSearch: state.enabledSearch,
      indexViewExplore: event.indexViewExplore,
    ));
  }

  // FutureOr<void> _onChangeAnimationToast(ChangeAnimationToast event, Emitter<ExploreState> emit) {
  //   emit(ExploreSuccess(
  //     visible: state.visible,
  //     opacity: event.opacity,
  //     statusMessage: state.statusMessage,
  //     query: state.query,
  //     enabledSearch: state.enabledSearch,
  //   ));
  // }

  // FutureOr<void> _onDisplayToast(DisplayToast event, Emitter<ExploreState> emit) {
  //   emit(ExploreSuccess(
  //     opacity: state.opacity,
  //     visible: event.visible,
  //     statusMessage: event.statusMessage,
  //     query: state.query,
  //     enabledSearch: state.enabledSearch,
  //   ));
  // }

  FutureOr<void> _onMoveToSearch(MoveToSearch event, Emitter<ExploreState> emit) {
    emit(ExploreSearchSuccess(
      indexViewExplore: state.indexViewExplore,
      opacity: state.opacity,
      visible: state.visible,
      statusMessage: state.statusMessage,
      query: state.query,
      enabledSearch: event.enabledSearch,
    ));
  }

  FutureOr<void> _onSearch(Search event, Emitter<ExploreState> emit) {
    emit(ExploreSearchSuccess(
      indexViewExplore: state.indexViewExplore,
      opacity: state.opacity,
      visible: state.visible,
      statusMessage: state.statusMessage,
      query: event.query,
      enabledSearch: state.enabledSearch,
    ));
  }

  FutureOr<void> _onClear(Clear event, Emitter<ExploreState> emit) {
    textController.clear();
    emit(ExploreSearchSuccess(
      indexViewExplore: state.indexViewExplore,
      opacity: state.opacity,
      visible: state.visible,
      statusMessage: state.statusMessage,
      query: textController.text,
      enabledSearch: state.enabledSearch,
    ));
  }

  @override
  Future<void> close() {
    textController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    return super.close();
  }
}
