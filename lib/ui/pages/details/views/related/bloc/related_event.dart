part of 'related_bloc.dart';

class RelatedEvent {}

class FetchDataRelated extends RelatedEvent {
  final int id;
  final int page;
  final String language;
  final MediaType mediaType;
  FetchDataRelated({
    required this.id,
    required this.page,
    required this.language,
    required this.mediaType,
  });
}

class AddWatchList extends RelatedEvent {
  final String mediaType;
  final int mediaId;
  final int index;
  AddWatchList({
    required this.mediaType,
    required this.mediaId,
    required this.index,
  });
}
