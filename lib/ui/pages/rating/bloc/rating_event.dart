part of 'rating_bloc.dart';

class RatingEvent {}

class FetchDataRating extends RatingEvent {
  final double value;
  FetchDataRating({
    required this.value,
  });
}

class AddRating extends RatingEvent {
  final int id;
  final MediaType mediaType;
  final double value;
  AddRating({
    required this.id,
    required this.mediaType,
    required this.value,
  });
}

class RemoveRating extends RatingEvent {
  final int id;
  final MediaType mediaType;
  RemoveRating({
    required this.id,
    required this.mediaType,
  });
}
