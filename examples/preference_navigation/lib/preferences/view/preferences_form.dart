import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_navigation/preferences/preferences.dart';

/// {@template preferences_form}
/// Handles the input of preferences.
/// {@endtemplate}
class PreferencesForm extends StatefulWidget {
  /// {@macro preferences_form}
  const PreferencesForm({super.key});

  @override
  State<PreferencesForm> createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
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
          TextFormField(
            key: const Key('preferencesForm_keyInput_textField'),
            controller: keyController,
            validator: validate,
          ),
          const SizedBox(height: 10),
          TextFormField(
            key: const Key('preferencesForm_valueInput_textField'),
            controller: valueController,
            validator: validate,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            key: const Key('preferencesForm_save_elevatedButton'),
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();

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
