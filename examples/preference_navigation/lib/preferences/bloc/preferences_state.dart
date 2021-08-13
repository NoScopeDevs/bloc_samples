part of 'preferences_bloc.dart';

/// {@template preferences_state}
/// Abstract class for possible [PreferencesBloc] states.
/// {@endtemplate}
abstract class PreferencesState extends Equatable {
  /// {@macro preferences_state}
  const PreferencesState();
}

/// [PreferencesBloc] initial state.
class PreferencesInitial extends PreferencesState {
  @override
  List<Object?> get props => [];
}

/// [PreferencesBloc] loading state.
class PreferencesLoading extends PreferencesState {
  @override
  List<Object?> get props => [];
}

/// [PreferencesBloc] empty state.
class PreferencesEmpty extends PreferencesState {
  @override
  List<Object?> get props => [];
}

/// {@template preferences_loaded_state}
/// [PreferencesBloc] loaded state.
/// Contains a `Map` with the user preferences.
/// {@endtemplate}
class PreferencesLoaded extends PreferencesState {
  /// {@macro preferences_loaded_state}
  const PreferencesLoaded(this.preferences);

  /// User preferences.
  final Map<String, dynamic> preferences;

  @override
  List<Object?> get props => [preferences];
}

/// {@template preferences_error_state}
/// [PreferencesBloc] error state.
/// Contains the error and its stack trace.
/// {@endtemplate}
class PreferencesError extends PreferencesState {
  /// {@macro preferences_error_state}
  const PreferencesError([this.error, this.stackTrace]);

  /// Error reason.
  final PreferenceFailureReason? error;

  /// Error stack trace.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}
