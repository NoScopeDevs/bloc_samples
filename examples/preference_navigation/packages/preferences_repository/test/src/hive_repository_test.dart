import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preferences_repository/preferences_repository.dart';
import 'package:preferences_repository/src/hive_repository.dart';

class MockHiveBox extends Mock implements Box<Object> {}

class FakePreferences extends Fake implements Box<Object> {}

class FakeModelHive extends HiveObject {}

void main() {
  late MockHiveBox mockHiveBox;
  late HivePreferencesRepository hiveRepository;
  late FakeModelHive tFakeModelHive;

  const keyTest1 = 'keyTest1';
  const responseTest1 = 'value11';

  setUp(() async {
    tFakeModelHive = FakeModelHive();
    mockHiveBox = MockHiveBox();
    hiveRepository = HivePreferencesRepository(box: mockHiveBox);
  });

  test('getValue', () {
    when(() => mockHiveBox.get(keyTest1)).thenReturn(responseTest1);

    final result = hiveRepository.getValue(keyTest1);

    expect(result, responseTest1);
  });

  group('saveValue', () {
    const testValues = {
      'int': 42,
      'double': 42.0,
      'bool': true,
      'String': 'foo',
      'List<String>': <String>['foo', 'bar'],
    };

    test('saves primitive types of values', () async {
      when(() => mockHiveBox.put('int', 42))
          .thenAnswer((_) async => Future.value());
      when(() => mockHiveBox.put('double', 42.0))
          .thenAnswer((_) async => Future.value());
      when(() => mockHiveBox.put('bool', true))
          .thenAnswer((_) async => Future.value());
      when(() => mockHiveBox.put('String', 'foo'))
          .thenAnswer((_) async => Future.value());
      when(() => mockHiveBox.put(
            'List<String>',
            ['foo', 'bar'],
          )).thenAnswer((_) async => Future.value());

      for (final entry in testValues.entries) {
        final key = entry.key;
        final value = entry.value;
        expect(hiveRepository.saveValue(key, value), completes);
      }
    });

    test('save model HiveObject', () {
      when(() => mockHiveBox.add(tFakeModelHive))
          .thenAnswer((_) async => Future<int>.value(0));

      expect(hiveRepository.saveValue('object_key', tFakeModelHive), completes);
    });

    test(
      'throws PreferenceFailure with typeNotSupported '
      'when value type is not supported',
      () async {
        final fakeValue = FakePreferences();

        await expectLater(
          hiveRepository.saveValue('key', fakeValue),
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
  });

  group('getKeys', () {
    const testKeys = {'foo', 'bar'};

    test('returns the set of string keys as a list', () {
      when(() => mockHiveBox.keys).thenReturn(testKeys);
      expect(hiveRepository.getKeys(), testKeys.toList());
    });

    test(
      'throws PreferenceError with noPreferences reason when '
      "preferences's set is empty",
      () {
        when(() => mockHiveBox.keys).thenReturn(<dynamic>[]);
        try {
          hiveRepository.getKeys();
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
        when(() => mockHiveBox.keys).thenThrow(Exception());
        try {
          hiveRepository.getKeys();
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
      when(() => mockHiveBox.get(any<dynamic>())).thenReturn(testValue);

      expect(hiveRepository.getValue('key'), isNotNull);
    });

    test('returns value correctly', () {
      when(() => mockHiveBox.get(any<dynamic>())).thenReturn(testValue);

      expect(hiveRepository.getValue('key'), testValue);
    });

    test(
      'throws PreferenceError with reason unknown '
      'when preferences.get throws any Exception',
      () {
        when(() => mockHiveBox.get(any<dynamic>())).thenThrow(Exception());

        try {
          final _ = hiveRepository.getValue('key');
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
        when(() => mockHiveBox.get(any<dynamic>())).thenReturn(null);
        try {
          hiveRepository.getValue('key');
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
      when(() => mockHiveBox.clear()).thenAnswer((_) async => 1);

      await expectLater(hiveRepository.clearValues(), completes);
    });

    test(
      'throws PreferenceError with clearWentWrong reason '
      'when preferences.clear throws a generic Exception',
      () async {
        when(() => mockHiveBox.clear()).thenThrow(Exception());
        await expectLater(
          hiveRepository.clearValues(),
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
}
