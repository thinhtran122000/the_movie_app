part of 'introduction_bloc.dart';

class IntroductionState {
  final bool hasAccount;
  final int id;
  final String name;
  final String username;
  final String profilePath;
  final List<String> listTitle;
  final List<List<MultipleMedia>> multipleList;
  IntroductionState({
    required this.hasAccount,
    required this.id,
    required this.name,
    required this.username,
    required this.profilePath,
    required this.listTitle,
    required this.multipleList,
  });
}

class IntroductionInitial extends IntroductionState {
  IntroductionInitial({
    required super.hasAccount,
    required super.username,
    required super.profilePath,
    required super.name,
    required super.id,
    required super.listTitle,
    required super.multipleList,
  });
}

class IntroductionSuccess extends IntroductionState {
  IntroductionSuccess({
    required super.hasAccount,
    required super.username,
    required super.profilePath,
    required super.name,
    required super.id,
    required super.listTitle,
    required super.multipleList,
  });
}

class IntroductionError extends IntroductionState {
  final String errorMessage;
  IntroductionError({
    required this.errorMessage,
    required super.hasAccount,
    required super.username,
    required super.profilePath,
    required super.name,
    required super.id,
    required super.listTitle,
    required super.multipleList,
  });
}
