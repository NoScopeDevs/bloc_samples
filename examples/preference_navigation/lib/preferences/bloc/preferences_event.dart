part of 'preferences_bloc.dart';

/// {@template preferences_event}
/// Abstract class for possible [PreferencesBloc] events.
/// {@endtemplate}
abstract class PreferencesEvent extends Equatable {
  /// {@macro preferences_event}
  const PreferencesEvent();

  @override
  List<Object> get props => [];
}

/// {@template preference_added}
/// [PreferencesEvent] triggered when user adds new value to preferences.
/// {@endtemplate}
class PreferenceAdded extends PreferencesEvent {
  /// {@macro preference_added}
  const PreferenceAdded(this.entry);

  /// New map entry to preferences.
  final Map<String, dynamic> entry;
}

/// [PreferencesEvent] triggered when app requests user preferences.
class PreferencesChecked extends PreferencesEvent {}

/// [PreferencesEvent] triggered when user requests deleting their preferences.
class PreferencesCleared extends PreferencesEvent {}
