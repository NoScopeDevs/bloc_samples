import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 12,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: ProfileForm(),
        ),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Name',
            ),
            validator: (name) => name!.trim().isEmpty ? 'Fill up' : null,
            onSaved: (name) => _name = name!,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Email',
            ),
            validator: (email) => email!.trim().isEmpty ? 'Fill up' : null,
            onSaved: (email) => _email = email!,
          ),
          TextButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              _formKey.currentState!.save();

              final event = ProfileAccountAdded(
                User(name: _name, email: _email),
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
