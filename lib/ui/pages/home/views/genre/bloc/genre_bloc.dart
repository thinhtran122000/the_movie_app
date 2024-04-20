import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/ui/pages/home/home_repository.dart';
import 'package:tmdb/utils/utils.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController movieController = ScrollController();
  ScrollController tvController = ScrollController();
  bool visibleMovie = true;
  bool visibleTv = false;
  GenreBloc()
      : super(GenreInitial(
          listGenreMovie: [],
          listGenreTv: [],
          listMovieImage: [],
          listTvImage: [],
          status: false,
        )) {
    on<FetchData>(_onFetchData);
    on<ChangeList>(_onChangeList);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<GenreState> emit) async {
    try {
      final movieResult = await homeRepository.getGenreMovie(language: event.language);
      final tvResult = await homeRepository.getGenreTv(language: event.language);
      final listMovie = await Future.wait(
        movieResult.object.genres.map<Future<List<MultipleMedia>>>((e) async {
          final movieResult = await homeRepository.getDiscoverMovie(
            language: event.language,
            page: 1,
            withGenres: [e.id ?? 0],
          );
          return movieResult.list;
        }).toList(),
      );
      final listMovieImage = listMovie.map<String>((e) {
        final itemMovie = e[Random().nextInt(e.length)];
        var movieImage = itemMovie.backdropPath ?? '';
        do {
          final newItemMovie = (e..shuffle())[Random().nextInt(e.length)];
          final newMovieImage = newItemMovie.backdropPath ?? '';
          movieImage = newMovieImage;
        } while (e.indexOf(itemMovie) < e.length && movieImage.isEmpty);
        return movieImage;
      }).toList();
      final listTv = await Future.wait(
        tvResult.object.genres.map<Future<List<MultipleMedia>>>((e) async {
          final tvResult = await homeRepository.getDiscoverTv(
            language: event.language,
            page: 1,
            withGenres: [e.id ?? 0],
          );
          return tvResult.list;
        }).toList(),
      );
      final listTvImage = listTv.map<String>((e) {
        final itemTv = e[Random().nextInt(e.length)];
        var tvImage = itemTv.backdropPath ?? '';
        do {
          final newItemTv = (e..shuffle())[Random().nextInt(e.length)];
          final newTvImage = newItemTv.backdropPath ?? '';
          tvImage = newTvImage;
        } while (e.indexOf(itemTv) < e.length && tvImage.isEmpty);
        return tvImage;
      }).toList();
      emit(GenreSuccess(
        listMovieImage: listMovieImage,
        listTvImage: listTvImage,
        listGenreMovie: movieResult.object.genres,
        listGenreTv: tvResult.object.genres,
        status: state.status,
      ));
    } catch (e) {
      emit(GenreError(
        errorMessage: e.toString(),
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
        listMovieImage: state.listMovieImage,
        listTvImage: state.listTvImage,
        status: state.status,
      ));
    }
  }

  FutureOr<void> _onChangeList(ChangeList event, Emitter<GenreState> emit) {
    try {
      emit(GenreSuccess(
        status: event.status,
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
        listMovieImage: state.listMovieImage,
        listTvImage: state.listTvImage,
      ));
    } catch (e) {
      emit(GenreError(
        errorMessage: e.toString(),
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
        listMovieImage: state.listMovieImage,
        listTvImage: state.listTvImage,
        status: state.status,
      ));
    }
  }
}
