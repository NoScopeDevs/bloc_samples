import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preference_navigation/start/start.dart';
import 'package:shared_preferences_repository/shared_preferences_repository.dart';

/// {@template app}
/// Main app widget for dependency injection.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    required SharedPreferencesRepository preferencesRepository,
    super.key,
  }) : _preferencesRepository = preferencesRepository;

  final SharedPreferencesRepository _preferencesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _preferencesRepository),
      ],
      child: BlocProvider(
        create: (context) => PreferencesBloc(
          repository: _preferencesRepository,
        )..add(PreferencesChecked()),
        child: const AppView(),
      ),
    );
  }
}

/// {@template app_view}
/// App widget to handle app's base configuration.
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}
