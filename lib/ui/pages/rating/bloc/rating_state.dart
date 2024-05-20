part of 'rating_bloc.dart';

class RatingState {
  final double value;
  RatingState({
    required this.value,
  });
}

class RatingInitial extends RatingState {
  RatingInitial({
    required super.value,
  });
}

class RatingLoaded extends RatingState {
  RatingLoaded({
    required super.value,
  });
}

class RatingSuccess extends RatingState {
  RatingSuccess({
    required super.value,
  });
}

class RatingError extends RatingState {
  final String errorMessage;
  RatingError({
    required this.errorMessage,
    required super.value,
  });
}
