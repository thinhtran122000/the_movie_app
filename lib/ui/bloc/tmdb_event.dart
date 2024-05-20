part of 'tmdb_bloc.dart';

class TmdbEvent {}

class NotifyStateChange extends TmdbEvent {
  final NotificationTypes notificationTypes;
  NotifyStateChange({
    required this.notificationTypes,
  });
}
