import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'browse_event.dart';
part 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final ScrollController scrollController = ScrollController();
  BrowseBloc() : super(BrowseInitial()) {
    on<LoadViewBrowse>(_onLoadViewBrowse);
  }

  FutureOr<void> _onLoadViewBrowse(LoadViewBrowse event, Emitter<BrowseState> emit) {
    emit(BrowseLoaded());
  }
}
