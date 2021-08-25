import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/signup/routes/routes.dart';
import 'package:form_flow/signup/signup.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: context.select((SignUpBloc bloc) => bloc.state),
      onGeneratePages: onGenerateSignUpPages,
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
