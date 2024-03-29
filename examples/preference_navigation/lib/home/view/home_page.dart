import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preference_navigation/start/start.dart';

/// {@template home_page}
/// Handles the home user interface.
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// Returns a [MaterialPageRoute] to navigate to `this` widget.
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: HomeView());
}

/// {@template home_view}
/// Handles the user interfaces for [PreferencesBloc] states.
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your saved values'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<PreferencesBloc>().add(PreferencesCleared());
            },
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<PreferencesBloc, PreferencesState>(
          listener: (_, state) async {
            if (state is PreferencesEmpty) {
              await Navigator.of(context).push<void>(StartPage.route());
            }
          },
          builder: (context, state) {
            if (state is PreferencesLoaded) {
              return PreferencesList(preferences: state.preferences);
            }
            return const Text('Something went wrong...');
          },
        ),
      ),
    );
  }
}

/// {@template preferences_list}
/// Handles the interface that shows the stored preferences.
/// {@endtemplate}
class PreferencesList extends StatelessWidget {
  /// {@macro preferences_list}
  const PreferencesList({
    required this.preferences,
    super.key,
  });

  /// Current preferences stored on device.
  final Map<String, dynamic> preferences;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: preferences.length,
      itemBuilder: (_, index) {
        final key = preferences.keys.elementAt(index);
        final value = preferences.values.elementAt(index) as String;
        return ListTile(
          title: Text(key),
          subtitle: Text(value),
        );
      },
    );
  }
}
