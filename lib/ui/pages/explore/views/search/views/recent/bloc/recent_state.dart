part of 'recent_bloc.dart';

abstract class RecentState {
  final List<MultipleMedia> listSearch;
  final List<MultipleMedia> listTrending;
  final String query;
  final bool visible;
  RecentState({
    required this.listSearch,
    required this.listTrending,
    required this.query,
    required this.visible,
  });
}

class RecentInitial extends RecentState {
  RecentInitial({
    required super.listSearch,
    required super.query,
    required super.listTrending,
    required super.visible,
  });
}

class RecentLoading extends RecentState {
  RecentLoading({
    required super.listSearch,
    required super.query,
    required super.listTrending,
    required super.visible,
  });
}

class RecentSuccess extends RecentState {
  RecentSuccess({
    required super.listSearch,
    required super.query,
    required super.listTrending,
    required super.visible,
  });
}

class RecentError extends RecentState {
  final String errorMessage;
  RecentError({
    required this.errorMessage,
    required super.listSearch,
    required super.listTrending,
    required super.query,
    required super.visible,
  });
}
