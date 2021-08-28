// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:preference_navigation/preferences/preferences.dart';

void main() {
  group('PreferencesState', () {
    test('supports value comparison', () {
      expect(PreferencesInitial(), equals(PreferencesInitial()));
    });
  });
}
