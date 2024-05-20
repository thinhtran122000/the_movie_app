part of 'details_bloc.dart';

abstract class DetailsEvent {}

class FetchDataDetails extends DetailsEvent {
  final int id;
  final MediaType mediaType;
  final String language;
  FetchDataDetails({
    required this.id,
    required this.mediaType,
    required this.language,
  });
}

class FetchFeature extends DetailsEvent {
  final int id;
  final MediaType mediaType;
  final String language;
  FetchFeature({
    required this.id,
    required this.mediaType,
    required this.language,
  });
}

class FetchState extends DetailsEvent {
  final int id;
  final MediaType mediaType;
  // final double? value;
  FetchState({
    required this.id,
    required this.mediaType,
    // this.value,
  });
}

class FetchCredits extends DetailsEvent {
  final int id;
  final String language;
  final MediaType mediaType;
  FetchCredits({
    required this.id,
    required this.mediaType,
    required this.language,
  });
}

class FetchRelated extends DetailsEvent {
  final int id;
  final String language;
  final MediaType mediaType;
  FetchRelated({
    required this.id,
    required this.mediaType,
    required this.language,
  });
}

class AddWatchlist extends DetailsEvent {
  final String mediaType;
  final int mediaId;
  AddWatchlist({
    required this.mediaType,
    required this.mediaId,
  });
}

class AddFavorites extends DetailsEvent {
  final String mediaType;
  final int mediaId;
  AddFavorites({
    required this.mediaType,
    required this.mediaId,
  });
}
