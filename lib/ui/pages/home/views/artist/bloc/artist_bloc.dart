import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home.dart';
import 'package:tmdb/utils/utils.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController scrollController = ScrollController();
  ArtistBloc() : super(ArtistInitial(listArtist: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<ArtistState> emit) async {
    try {
      var result = await homeRepository.getPopularArtist(
        language: event.language,
        page: event.page,
      );
      emit(ArtistSuccess(listArtist: result.list));
    } catch (e) {
      emit(ArtistError(
        errorMessage: e.toString(),
        listArtist: state.listArtist,
      ));
    }
  }
}
