/// Possible reasons why preferences failed.
enum PreferenceFailureReason {
  ///
  unknown,

  /// A value type not supported was given.
  typeNotSupported,

  /// Couldn't return preference keys
  noPreferences,

  /// Value returned was null.
  nullValue,

  /// Couldn't clear preferences.
  clearWentWrong,
}

/// {@template preferences_failure}
/// Thrown if any error comes up when interacting with preferences.
/// {@endtemplate}
class PreferenceFailure implements Exception {
  /// {@macro preferences_failure}
  PreferenceFailure(this.reason);

  /// Why the failure happened
  final PreferenceFailureReason reason;
}
