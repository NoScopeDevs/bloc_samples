import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_navigation/home/home.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preference_navigation/start/start.dart';

/// {@template preferences_page}
/// Handles the preferences user interfaces.
/// {@endtemplate}
class PreferencesPage extends StatelessWidget {
  /// {@macro preferences_page}
  const PreferencesPage({super.key});

  /// Returns a [MaterialPageRoute] to navigate to `this` widget.
  static Route<void> go() {
    return MaterialPageRoute<void>(builder: (_) => const PreferencesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<PreferencesBloc, PreferencesState>(
          listener: (_, state) async {
            if (state is PreferencesLoaded) {
              await Navigator.of(context).push<void>(HomePage.go());
            }
            if (state is PreferencesError) {
              // ignore: use_build_context_synchronously
              await Navigator.of(context).pushReplacement<void, void>(
                StartPage.go(),
              );
            }
          },
          child: const PreferencesForm(),
        ),
      ),
    );
  }
}
