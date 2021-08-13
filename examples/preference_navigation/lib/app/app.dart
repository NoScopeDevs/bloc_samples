import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_navigation/start/start.dart';
import 'package:preferences_repository/preferences_repository.dart';

/// {@template app}
/// Main app widget for dependency injection.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    Key? key,
    required PreferencesRepository preferencesRepository,
  })  : _preferencesRepository = preferencesRepository,
        super(key: key);

  final PreferencesRepository _preferencesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _preferencesRepository),
      ],
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// App widget to handle app's base configuration.
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({Key? key}) : super(key: key);

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
