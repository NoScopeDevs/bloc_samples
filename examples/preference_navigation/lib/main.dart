import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:preference_navigation/app/app.dart';
import 'package:preference_navigation/app/app_bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_repository/shared_preferences_repository.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      FlutterServicesBinding.ensureInitialized();
      final preferences = await SharedPreferences.getInstance();
      final preferencesRepository = SharedPreferencesRepository(
        sharedPreferences: preferences,
      );
      BlocOverrides.runZoned(
        () => runApp(
          App(preferencesRepository: preferencesRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
