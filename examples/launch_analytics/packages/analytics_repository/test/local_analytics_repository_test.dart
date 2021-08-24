// ignore_for_file: prefer_const_constructors
import 'package:analytics_repository/analytics_repository.dart';
import 'package:local_analytics_api/local_analytics_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLocalAnalyticsApi extends Mock implements LocalAnalyticsApi {}

void main() {
  group('LocalAnalyticsRepository', () {
    test('can be instantiated', () {
      expect(AnalyticsRepository(MockLocalAnalyticsApi()), isNotNull);
    });
  });
}
