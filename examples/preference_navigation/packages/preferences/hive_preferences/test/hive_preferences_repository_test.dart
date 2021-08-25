import 'package:hive/hive.dart';
import 'package:hive_preferences/hive_preferences.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preferences_repository/preferences_repository.dart';
import 'package:test/test.dart';

class MockHivePreferencesRepository extends Mock
    implements HivePreferencesRepository {}

class MockBox extends Mock implements Box<Object> {}

class FakeHiveObject extends HiveObject {}

void main() {
  late MockBox mockBox;
  late HivePreferencesRepository hiveRepository;
  late FakeHiveObject tFakeHiveObject;

  const keyTest1 = 'keyTest1';
  const responseTest1 = 'value11';

  setUp(() async {
    tFakeHiveObject = FakeHiveObject();
    mockBox = MockBox();
    hiveRepository = HivePreferencesRepository(box: mockBox);
  });

  test('getValue', () {
    when(() => mockBox.get(keyTest1)).thenReturn(responseTest1);

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
      when(() => mockBox.put('int', 42))
          .thenAnswer((_) async => Future.value());
      when(() => mockBox.put('double', 42.0))
          .thenAnswer((_) async => Future.value());
      when(() => mockBox.put('bool', true))
          .thenAnswer((_) async => Future.value());
      when(() => mockBox.put('String', 'foo'))
          .thenAnswer((m) async => Future.value());
      when(() => mockBox.put(
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
      when(() => mockBox.add(tFakeHiveObject))
          .thenAnswer((_) async => Future<int>.value(0));

      expect(
          hiveRepository.saveValue('object_key', tFakeHiveObject), completes);
    });

    test(
      'throws PreferenceFailure with typeNotSupported '
      'when value type is not supported',
      () async {
        await expectLater(
          hiveRepository.saveValue('key', mockBox),
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
      when(() => mockBox.keys).thenReturn(testKeys);
      expect(hiveRepository.getKeys(), testKeys.toList());
    });

    test(
      'throws PreferenceError with noPreferences reason when '
      "preferences's set is empty",
      () {
        when(() => mockBox.keys).thenReturn(<dynamic>[]);
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
        when(() => mockBox.keys).thenThrow(Exception());
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
      when(() => mockBox.get(any<dynamic>())).thenReturn(testValue);

      expect(hiveRepository.getValue('key'), isNotNull);
    });

    test('returns value correctly', () {
      when(() => mockBox.get(any<dynamic>())).thenReturn(testValue);

      expect(hiveRepository.getValue('key'), testValue);
    });

    test(
      'throws PreferenceError with reason unknown '
      'when preferences.get throws any Exception',
      () {
        when(() => mockBox.get(any<dynamic>())).thenThrow(Exception());

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
        when(() => mockBox.get(any<dynamic>())).thenReturn(null);
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
      when(() => mockBox.clear()).thenAnswer((_) async => 1);

      await expectLater(hiveRepository.clearValues(), completes);
    });

    test(
      'throws PreferenceError with clearWentWrong reason '
      'when preferences.clear throws a generic Exception',
      () async {
        when(() => mockBox.clear()).thenThrow(Exception());
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
