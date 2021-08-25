# preference_navigation

Project to handle navigation based on locally stored preferences.

Make sure to use `WidgetsFlutterBinding.ensureInitialized()` to avoid errors when launching the app.

It has two implementations based on the type of local storage that you choose as a dependency.

In case of using `hive` as a preference, you should only inject `HivePreferencesRepository` into the `PreferencesBloc`.

You must change the Mock defined in line `27` of the `pump_app.dart` file in the `test/helpers/` folder to `MockHivePreferencesRepository`.

## Example

Using `shared_preferences` as dependency and in turn `SharedPreferencesRepository` as repository.

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
    return BlocProvider(
      create: (context) => PreferencesBloc(repository: _preferencesRepository)
        ..add(PreferencesChecked()),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
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
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
