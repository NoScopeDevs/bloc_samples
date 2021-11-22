import 'dart:developer';

import 'package:analytics_repository/analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_analytics/app/app.dart';
import 'package:local_analytics_api/local_analytics_api.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  await HydratedBlocOverrides.runZoned(
    () async {
      await Hive.initFlutter();
      final box = await Hive.openBox<int>('test');

      final localAnalyticsRepo = AnalyticsRepository(
        LocalAnalyticsApi(box),
      );

      runApp(
        App(localAnalyticsRepository: localAnalyticsRepo),
      );
    },
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
