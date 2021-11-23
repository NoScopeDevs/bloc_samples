// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preferences_repository/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_repository/shared_preferences_repository.dart';

class MockPreferences extends Mock implements SharedPreferences {}

class FakeSharedPreferences extends Fake implements SharedPreferences {}

void main() {
  late SharedPreferencesRepository repository;
  late SharedPreferences mockPreferences;

  setUpAll(() {
    mockPreferences = MockPreferences();
    repository =
        SharedPreferencesRepository(sharedPreferences: mockPreferences);
  });

  group('PreferencesRepository', () {
    test('can be instantiated', () {
      expect(
        SharedPreferencesRepository(sharedPreferences: mockPreferences),
        isNotNull,
      );
    });

    group('saveValue', () {
      const testValues = {
        'int': 42,
        'double': 42.0,
        'bool': true,
        'String': 'foo',
        'List<String>': ['foo', 'bar'],
      };

      test('saves supported values', () async {
        when(() => mockPreferences.setInt(any(), any()))
            .thenAnswer((_) async => true);
        when(() => mockPreferences.setDouble(any(), any()))
            .thenAnswer((_) async => true);
        when(() => mockPreferences.setBool(any(), any()))
            .thenAnswer((_) async => true);
        when(() => mockPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);
        when(() => mockPreferences.setStringList(any(), any()))
            .thenAnswer((_) async => true);

        for (final entry in testValues.entries) {
          final key = entry.key;
          final value = entry.value;
          expect(repository.saveValue(key, value), completes);
        }
      });

      test(
        'throws PreferenceFailure with typeNotSupported '
        'when value type is not supported',
        () async {
          final fakeValue = FakeSharedPreferences();

          await expectLater(
            repository.saveValue('key', fakeValue),
            throwsA(
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.typeNotSupported,
              ),
            ),
          );
        },
      );

      test('rethrows PreferenceError when PreferenceError is thrown', () async {
        when(() => mockPreferences.setInt(any(), any())).thenThrow(
          PreferenceFailure(PreferenceFailureReason.typeNotSupported),
        );
        when(() => mockPreferences.setDouble(any(), any())).thenThrow(
          PreferenceFailure(PreferenceFailureReason.typeNotSupported),
        );
        when(() => mockPreferences.setBool(any(), any())).thenThrow(
          PreferenceFailure(PreferenceFailureReason.typeNotSupported),
        );
        when(() => mockPreferences.setString(any(), any())).thenThrow(
          PreferenceFailure(PreferenceFailureReason.typeNotSupported),
        );
        when(() => mockPreferences.setStringList(any(), any())).thenThrow(
          PreferenceFailure(PreferenceFailureReason.typeNotSupported),
        );

        for (final entry in testValues.entries) {
          final key = entry.key;
          final value = entry.value;

          await expectLater(
            repository.saveValue(key, value),
            throwsA(
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.typeNotSupported,
              ),
            ),
          );
        }
      });

      test(
        'throws PreferenceError with unknown reason '
        'when generic Exception is thrown',
        () async {
          when(() => mockPreferences.setInt(any(), any()))
              .thenThrow(Exception());
          when(() => mockPreferences.setDouble(any(), any()))
              .thenThrow(Exception());
          when(() => mockPreferences.setBool(any(), any()))
              .thenThrow(Exception());
          when(() => mockPreferences.setString(any(), any()))
              .thenThrow(Exception());
          when(() => mockPreferences.setStringList(any(), any()))
              .thenThrow(Exception());

          for (final entry in testValues.entries) {
            final key = entry.key;
            final value = entry.value;

            await expectLater(
              repository.saveValue(key, value),
              throwsA(
                isA<PreferenceFailure>().having(
                  (e) => e.reason,
                  'reason',
                  PreferenceFailureReason.unknown,
                ),
              ),
            );
          }
        },
      );
    });

    group('getKeys', () {
      const testKeys = {'foo', 'bar'};

      test('returns the set of string keys as a list', () {
        when(() => mockPreferences.getKeys()).thenReturn(testKeys);
        expect(repository.getKeys(), testKeys.toList());
      });

      test(
        'throws PreferenceError with noPreferences reason '
        "when preferences's set is empty",
        () {
          when(() => mockPreferences.getKeys()).thenReturn({});
          try {
            repository.getKeys();
          } catch (e) {
            expect(
              e,
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.noPreferences,
              ),
            );
          }
        },
      );

      test(
        'throws PreferenceError with unknown reason '
        'when generic Exception is thrown',
        () {
          when(() => mockPreferences.getKeys()).thenThrow(Exception());
          try {
            repository.getKeys();
          } catch (e) {
            expect(
              e,
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.unknown,
              ),
            );
          }
        },
      );
    });

    group('getValue', () {
      const testValue = 42;

      test('returns value a non-null value', () {
        when(() => mockPreferences.get(any())).thenReturn(testValue);
        expect(repository.getValue('key'), isNotNull);
      });

      test('returns value correctly', () {
        when(() => mockPreferences.get(any())).thenReturn(testValue);
        expect(repository.getValue('key'), testValue);
      });

      test(
        'throws PreferenceError with reason unknown '
        'when preferences.get throws any Exception',
        () {
          when(() => mockPreferences.get(any())).thenThrow(Exception());

          try {
            final _ = repository.getValue('key');
          } catch (e) {
            expect(
              e,
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.unknown,
              ),
            );
          }
        },
      );

      test(
        'throws PreferenceError with reason nullValue '
        'when preferences.get returns a null value',
        () {
          when(() => mockPreferences.get(any())).thenReturn(null);
          try {
            repository.getValue('key');
          } catch (e) {
            expect(
              e,
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.nullValue,
              ),
            );
          }
        },
      );
    });

    group('clearValues', () {
      test('clears correctly', () async {
        when(() => mockPreferences.clear()).thenAnswer((_) async => true);
        await expectLater(repository.clearValues(), completes);
      });

      test(
        'throws PreferenceError with clearWentWrong reason '
        'when preferences.clear throws a generic Exception',
        () async {
          when(() => mockPreferences.clear()).thenThrow(Exception());
          await expectLater(
            repository.clearValues(),
            throwsA(
              isA<PreferenceFailure>().having(
                (e) => e.reason,
                'reason',
                PreferenceFailureReason.clearWentWrong,
              ),
            ),
          );
        },
      );
    });
  });
}
