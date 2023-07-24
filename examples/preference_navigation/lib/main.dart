import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:preference_navigation/app/app.dart';
import 'package:preference_navigation/app/app_bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_repository/shared_preferences_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final preferences = await SharedPreferences.getInstance();
  final preferencesRepository = SharedPreferencesRepository(
    sharedPreferences: preferences,
  );

  runApp(
    App(
      preferencesRepository: preferencesRepository,
    ),
  );
}
