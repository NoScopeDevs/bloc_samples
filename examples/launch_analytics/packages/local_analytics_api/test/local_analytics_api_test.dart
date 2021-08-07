// ignore_for_file: prefer_const_constructors
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:local_analytics_api/local_analytics_api.dart';

class MockBox extends Mock implements Box<int> {}

void main() {
  group('LocalAnalyticsApi', () {
    late Box<int> box;

    setUp(() {
      box = MockBox();
    });

    test('can be instantiated', () {
      expect(LocalAnalyticsApi(box), isNotNull);
    });

    group('increaseOpeningsCounter', () {
      test('calls box put method to save the value', () async {
        when(() => box.put(any<String>(), any<int>())).thenAnswer(
          (_) async {},
        );

        when(() => box.get(any<String>())).thenAnswer(
          (_) => 0,
        );

        final repo = LocalAnalyticsApi(box);

        // ignore: cascade_invocations
        repo.increaseOpeningsCounter();

        verify(() => box.put(any<String>(), any<int>())).called(1);
        verify(() => box.get(any<String>())).called(1);
      });
    });

    group('getOpeningsCounter', () {
      test('calls box get method to retrieve the value', () async {
        when(() => box.get(any<String>())).thenAnswer(
          (_) => 0,
        );

        final repo = LocalAnalyticsApi(box);

        // ignore: cascade_invocations
        repo.getOpeningsCounter();

        verify(() => box.get(any<String>())).called(1);
      });
    });
  });
}
