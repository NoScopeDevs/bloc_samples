import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_navigation/home/home.dart';
import 'package:preference_navigation/preferences/preferences.dart';

/// {@template start_page}
/// Handles the initial page dependency injection.
/// {@endtemplate}
class StartPage extends StatelessWidget {
  /// {@macro start_page}
  const StartPage({Key? key}) : super(key: key);

  /// Returns a [MaterialPageRoute] to navigate to `this` widget.
  static Route go() {
    return MaterialPageRoute<void>(builder: (_) => const StartPage());
  }

  @override
  Widget build(BuildContext context) {
    return const StartView();
  }
}

/// {@template start_view}
/// Handles the initial page user interfaces.
/// {@endtemplate}
class StartView extends StatelessWidget {
  /// {@macro start_view}
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<PreferencesBloc, PreferencesState>(
          listener: (_, state) async {
            if (state is PreferencesLoaded) {
              await Navigator.of(context).pushReplacement<void, void>(
                HomePage.go(),
              );
            }
            if (state is PreferencesError) {
              // ignore: use_build_context_synchronously
              await Navigator.of(context).pushReplacement<void, void>(
                PreferencesPage.go(),
              );
            }
          },
          builder: (_, state) {
            if (state is PreferencesInitial) return const Text('Hello there.');
            if (state is PreferencesLoaded) return const Text('Prefs loaded.');
            if (state is PreferencesError) return const Text('Oops.');
            if (state is PreferencesEmpty) return const NoPreferences();
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

/// {@template no_preferences}
/// Navigates to the [PreferencesPage].
/// {@endtemplate}
class NoPreferences extends StatelessWidget {
  /// {@macro no_preferences}
  const NoPreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('No prefs.'),
        const SizedBox(height: 15),
        TextButton(
          key: const Key('noPreferences_go_textButton'),
          onPressed: () => Navigator.of(context).push<void>(
            PreferencesPage.go(),
          ),
          child: const Text('Go to preferences'),
        ),
      ],
    );
  }
}
