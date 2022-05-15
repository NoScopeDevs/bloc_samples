import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  String? validate(String? value) => value!.isEmpty ? 'Fill up' : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: const Key('profileForm_nameInput_textField'),
            controller: nameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Name',
            ),
            validator: validate,
          ),
          TextFormField(
            key: const Key('profileForm_emailInput_textField'),
            controller: emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Email',
            ),
            validator: validate,
          ),
          TextButton(
            key: const Key('profileForm_save_textButton'),
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();

              final event = ProfileAccountAdded(
                User(
                  name: nameController.text,
                  email: emailController.text,
                ),
              );
              context.read<ProfileBloc>().add(event);

              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
