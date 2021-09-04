// ignore_for_file: prefer_const_constructors
import 'package:analytics_repository/analytics_repository.dart';
import 'package:local_analytics_api/local_analytics_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLocalAnalyticsApi extends Mock implements LocalAnalyticsApi {}

void main() {
  group('LocalAnalyticsRepository', () {
    late LocalAnalyticsApi localAnalyticsApi;

    setUp(() {
      localAnalyticsApi = MockLocalAnalyticsApi();
    });
    test('can be instantiated', () {
      expect(AnalyticsRepository(MockLocalAnalyticsApi()), isNotNull);
    });

    group('getOpeningsCount', () {
      test('calls the localAnalyticsApi and gets the count', () async {
        const tCount = 0;

        when(() => localAnalyticsApi.getOpeningsCounter()).thenReturn(tCount);

        final repo = AnalyticsRepository(localAnalyticsApi);

        // ignore: cascade_invocations
        final result = repo.getOpeningsCount();

        expect(result, tCount);
        verify(() => localAnalyticsApi.getOpeningsCounter()).called(1);
      });
    });

    group('increaseOpeningsCount', () {
      test('calls the localAnalyticsApi and increase the count', () async {
        when(() => localAnalyticsApi.increaseOpeningsCounter())
            .thenReturn(null);

        final repo = AnalyticsRepository(localAnalyticsApi);

        // ignore: cascade_invocations
        repo.increaseOpeningsCount();

        verify(() => localAnalyticsApi.increaseOpeningsCounter()).called(1);
      });
    });
  });
}
