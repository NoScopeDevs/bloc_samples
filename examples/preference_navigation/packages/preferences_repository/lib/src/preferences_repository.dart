import 'package:shared_preferences/shared_preferences.dart';

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

/// {@template preferences_repository}
/// A Flutter package to manage preferences business rules.
/// {@endtemplate}
class PreferencesRepository {
  /// {@macro preferences_repository}
  const PreferencesRepository({
    required SharedPreferences sharedPreferences,
  }) : _preferences = sharedPreferences;

  final SharedPreferences _preferences;

  /// Saves an object to preferences.
  /// Expects a [key] and a [value].
  Future<void> saveValue(String key, Object value) async {
    try {
      if (value is int) {
        await _preferences.setInt(key, value);
        return;
      }
      if (value is double) {
        await _preferences.setDouble(key, value);
        return;
      }
      if (value is bool) {
        await _preferences.setBool(key, value);
        return;
      }
      if (value is String) {
        await _preferences.setString(key, value);
        return;
      }
      if (value is List<String>) {
        await _preferences.setStringList(key, value);
        return;
      }

      throw TypeError();
    } on TypeError {
      throw PreferenceFailure(PreferenceFailureReason.typeNotSupported);
    } on PreferenceFailure {
      rethrow;
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.unknown);
    }
  }

  /// Returns a [List] containing all the keys for values stored in preferences.
  List<String> getKeys() {
    try {
      final preferencesKeys = _preferences.getKeys();
      if (preferencesKeys.isEmpty) {
        throw PreferenceFailure(PreferenceFailureReason.noPreferences);
      }
      return preferencesKeys.toList();
    } on PreferenceFailure {
      rethrow;
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.unknown);
    }
  }

  /// Returns an [Object] based on a given key.
  Object getValue(String key) {
    final Object? value;
    try {
      value = _preferences.get(key);
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.unknown);
    }
    if (value == null) {
      throw PreferenceFailure(PreferenceFailureReason.nullValue);
    }
    return value;
  }

  /// Clears every stored value on preferences.
  Future<void> clearValues() async {
    try {
      await _preferences.clear();
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.clearWentWrong);
    }
  }
}
