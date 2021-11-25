import 'package:local_analytics_api/local_analytics_api.dart';

/// {@template local_analytics_repository}
/// Manages analytics business rules.
/// {@endtemplate}
class AnalyticsRepository {
  /// {@macro local_analytics_repository}
  const AnalyticsRepository(LocalAnalyticsApi localAnalyticsApi)
      : _localAnalyticsApi = localAnalyticsApi;

  final LocalAnalyticsApi _localAnalyticsApi;

  int getOpeningsCount() {
    return _localAnalyticsApi.getOpeningsCounter();
  }

  void increaseOpeningsCount() {
    _localAnalyticsApi.increaseOpeningsCounter();
  }
}
