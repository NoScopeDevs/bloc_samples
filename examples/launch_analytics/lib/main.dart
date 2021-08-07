import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_analytics_api/local_analytics_api.dart';
import 'package:analytics_repository/analytics_repository.dart';

import 'package:launch_analytics/app/app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  final box = await Hive.openBox<int>('test');

  final localAnalyticsRepo = AnalyticsRepository(
    LocalAnalyticsApi(box),
  );

  runApp(
    App(localAnalyticsRepository: localAnalyticsRepo),
  );
}
