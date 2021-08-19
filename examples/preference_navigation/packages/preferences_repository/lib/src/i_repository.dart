/// Interface to manage preferences business rules.
abstract class IPreferencesRepository {
  /// Saves an object to preferences.
  /// Expects a [key] and a [value].
  Future<void> saveValue(String key, Object value);

  /// Returns a [List] containing all the keys for values stored in preferences.
  List<String> getKeys();

  /// Returns an [Object] based on a given key.
  Object? getValue(String key);

  /// Clears every stored value on preferences.
  Future<void> clearValues();
}
