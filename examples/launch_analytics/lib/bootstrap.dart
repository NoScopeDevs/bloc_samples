// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:analytics_repository/analytics_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_analytics/app/app.dart';
import 'package:local_analytics_api/local_analytics_api.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  Bloc.observer = AppBlocObserver();
  FlutterServicesBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  await Hive.initFlutter();
  final box = await Hive.openBox<int>('test');
  final localAnalyticsRepo = AnalyticsRepository(
    LocalAnalyticsApi(box),
  );

  runApp(
    App(localAnalyticsRepository: localAnalyticsRepo),
  );
}
