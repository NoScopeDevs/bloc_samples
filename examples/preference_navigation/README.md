# preference_navigation

Project to manage navigation from saved preferences.

It has two types of implementation based on the type of preferences that you choose as a dependency injection.

## [SharedPreference](https://pub.dev/packages/shared_preferences)

```dart
class App extends StatelessWidget {
  const App({
    Key? key,
    required SharedPreferencesRepository preferencesRepository,
  })  : _preferencesRepository = preferencesRepository,
        super(key: key);

  final SharedPreferencesRepository _preferencesRepository;

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

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferencesBloc(
        repository: context.read<SharedPreferencesRepository>(),
      )..add(PreferencesChecked()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Navigation App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartPage(),
      ),
    );
  }
}

```

## [Hive](https://pub.dev/packages/hive)

```dart
class App extends StatelessWidget {
  const App({
    Key? key,
    required HiveRepository preferencesRepository,
  })  : _preferencesRepository = preferencesRepository,
        super(key: key);

  final HiveRepository _preferencesRepository;

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

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferencesBloc(
        repository: context.read<HiveRepository>(),
      )..add(PreferencesChecked()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Navigation App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartPage(),
      ),
    );
  }
}

```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
