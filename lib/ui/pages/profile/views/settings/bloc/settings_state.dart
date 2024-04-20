part of 'settings_bloc.dart';

class SettingsState {
  final bool hasUser;
  SettingsState({
    required this.hasUser,
  });
}

class SettingsInitial extends SettingsState {
  SettingsInitial({required super.hasUser});
}

class SettingsLoaded extends SettingsState {
  SettingsLoaded({required super.hasUser});
}

class SettingsSuccess extends SettingsState {
  SettingsSuccess({required super.hasUser});
}

class SettingsError extends SettingsState {
  final String errorMessage;
  SettingsError({
    required this.errorMessage,
    required super.hasUser,
  });
}
