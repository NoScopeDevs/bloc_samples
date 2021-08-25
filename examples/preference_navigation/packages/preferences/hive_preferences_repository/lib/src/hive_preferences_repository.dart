import 'package:hive/hive.dart';
import 'package:preferences_repository/preferences_repository.dart';

/// {@template hive_preferences_repository}
/// Implementation the [PreferencesRepository] with Hive
/// {@endtemplate}
class HivePreferencesRepository implements PreferencesRepository {
  /// {@macro hive_preferences_repository}
  HivePreferencesRepository({required Box<Object> box}) : _box = box;

  final Box<Object> _box;

  @override
  Future<void> clearValues() async {
    try {
      await _box.clear();
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.clearWentWrong);
    }
  }

  @override
  List<String> getKeys() {
    try {
      final keys = List<String>.from(_box.keys);
      if (keys.isEmpty) {
        throw PreferenceFailure(PreferenceFailureReason.noPreferences);
      }
      return List<String>.from(_box.keys);
    } on PreferenceFailure {
      rethrow;
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.unknown);
    }
  }

  @override
  Object? getValue(String key) {
    final Object? value;
    try {
      value = _box.get(key);
    } catch (_) {
      throw PreferenceFailure(PreferenceFailureReason.unknown);
    }
    if (value == null) {
      throw PreferenceFailure(PreferenceFailureReason.nullValue);
    }
    return value;
  }

  @override
  Future<void> saveValue(String key, Object value) async {
    try {
      if (value is HiveObject) {
        await _box.add(value);
        return;
      }
      return _box.put(key, value);
    } catch (e) {
      throw PreferenceFailure(PreferenceFailureReason.typeNotSupported);
    }
  }
}
