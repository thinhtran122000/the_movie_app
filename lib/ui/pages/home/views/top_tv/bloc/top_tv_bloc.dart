import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'top_tv_event.dart';
part 'top_tv_state.dart';

class TopTvBloc extends Bloc<TopTvEvent, TopTvState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController scrollController = ScrollController();
  TopTvBloc() : super(TopTvInitial(listTopTv: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TopTvState> emit) async {
    try {
      var result = await homeRepository.getTopRatedTv(
        language: event.language,
        page: event.page,
      );
      emit(TopTvSuccess(listTopTv: result.list));
    } catch (e) {
      emit(TopTvError(
        errorMessage: e.toString(),
        listTopTv: state.listTopTv,
      ));
    }
  }
}
