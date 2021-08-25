import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('SignUpPage'),
    );
  }
}

class CredentialsForm extends StatelessWidget {
  const CredentialsForm({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CredentialsForm());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BiographyInput extends StatelessWidget {
  const BiographyInput({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: BiographyInput());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PinInput extends StatelessWidget {
  const PinInput({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: PinInput());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
