part of 'movie_bloc.dart';

class MovieState {
  final List<List<MultipleMedia>> multipleList;
  final List<String> listTitle;
  MovieState({
    required this.multipleList,
    required this.listTitle,
  });
}

class MovieInitial extends MovieState {
  MovieInitial({
    required super.multipleList,
    required super.listTitle,
  });
}

class MovieSuccess extends MovieState {
  MovieSuccess({
    required super.multipleList,
    required super.listTitle,
  });
}

class MovieError extends MovieState {
  final String errorMessage;
  MovieError({
    required this.errorMessage,
    required super.multipleList,
    required super.listTitle,
  });
}
