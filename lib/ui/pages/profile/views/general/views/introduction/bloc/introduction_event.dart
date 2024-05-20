part of 'introduction_bloc.dart';

class IntroductionEvent {}

class FetchData extends IntroductionEvent {
  final String language;
  final String sortBy;
  FetchData({
    required this.language,
    required this.sortBy,
  });
}
