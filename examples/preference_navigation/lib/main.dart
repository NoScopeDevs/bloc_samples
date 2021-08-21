import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:preference_navigation/app/app.dart';
import 'package:preference_navigation/app/app_bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_nsd/shared_preferences.dart';

Future<void> main() async {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = AppBlocObserver();

  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final preferences = await SharedPreferences.getInstance();
      final preferencesRepository = SharedPreferencesRepository(
        sharedPreferences: preferences,
      );

      runApp(
        App(preferencesRepository: preferencesRepository),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
