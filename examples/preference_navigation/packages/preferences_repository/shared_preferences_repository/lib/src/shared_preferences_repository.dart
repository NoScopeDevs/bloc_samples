import 'package:preferences_repository/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template shared_preferences_repository}
/// A Flutter package to manage preferences business rules.
/// {@endtemplate}
class SharedPreferencesRepository implements PreferencesRepository {
  /// {@macro shared_preferences_repository}
  SharedPreferencesRepository({
    required SharedPreferences sharedPreferences,
  }) : _preferences = sharedPreferences;

  final SharedPreferences _preferences;

  @override
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
      throw PreferenceFailure(PreferenceFailureReason.typeNotSupported);
    } on PreferenceFailure {
      rethrow;
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.unknown);
    }
  }

  @override
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

  @override
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

  @override
  Future<void> clearValues() async {
    try {
      await _preferences.clear();
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.clearWentWrong);
    }
  }
}
