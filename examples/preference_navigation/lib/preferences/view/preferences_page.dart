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
  const PreferencesPage({Key? key}) : super(key: key);

  /// Returns a [MaterialPageRoute] to navigate to `this` widget.
  static Route go() {
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
          child: const PreferenceForm(),
        ),
      ),
    );
  }
}

/// {@template preferences_form}
/// Handles the input of preferences.
/// {@endtemplate}
class PreferenceForm extends StatefulWidget {
  /// {@macro preferences_form}
  const PreferenceForm({Key? key}) : super(key: key);

  @override
  _PreferenceFormState createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  final formKey = GlobalKey<FormState>();
  final keyController = TextEditingController();
  final valueController = TextEditingController();

  String? validate(String? value) => value!.isEmpty ? 'Type something' : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        shrinkWrap: true,
        children: [
          TextFormField(controller: keyController, validator: validate),
          const SizedBox(height: 10),
          TextFormField(controller: valueController, validator: validate),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final key = keyController.text;
              final value = valueController.text;

              context
                  .read<PreferencesBloc>()
                  .add(PreferenceAdded(<String, dynamic>{key: value}));
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
