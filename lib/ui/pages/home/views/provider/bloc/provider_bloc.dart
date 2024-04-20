import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  final ScrollController movieController = ScrollController();
  final ScrollController tvController = ScrollController();
  ProviderBloc()
      : super(ProviderInitial(
          status: false,
          listMovieProviders: [],
          listTvProviders: [],
        )) {
    on<FetchData>(_onFetchData);
    on<ChangeList>(_onChangeList);
  }
  FutureOr<void> _onFetchData(FetchData event, Emitter<ProviderState> emit) async {
    try {
      final movieResult = await homeRepository.getMovieProvider(
        language: event.language,
        watchRegion: event.watchRegion ?? '',
      );
      final tvResult = await homeRepository.getTvProvider(
        language: event.language,
        watchRegion: event.watchRegion ?? '',
      );
      emit(ProviderSuccess(
        status: state.status,
        listMovieProviders: movieResult.list,
        listTvProviders: tvResult.list,
      ));
    } catch (e) {
      emit(ProviderError(
        errorMessage: e.toString(),
        status: state.status,
        listMovieProviders: state.listMovieProviders,
        listTvProviders: state.listTvProviders,
      ));
    }
  }

  FutureOr<void> _onChangeList(ChangeList event, Emitter<ProviderState> emit) {
    try {
      emit(ProviderSuccess(
        listMovieProviders: state.listMovieProviders,
        listTvProviders: state.listTvProviders,
        status: event.status,
      ));
    } catch (e) {
      emit(ProviderError(
        errorMessage: e.toString(),
        status: state.status,
        listMovieProviders: state.listMovieProviders,
        listTvProviders: state.listTvProviders,
      ));
    }
  }
}
