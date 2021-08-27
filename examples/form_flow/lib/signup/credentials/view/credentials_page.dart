import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/signup/signup.dart';

class CredentialsPage extends StatelessWidget {
  const CredentialsPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CredentialsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CredentialsCubit(),
      child: const CredentialsView(),
    );
  }
}

class CredentialsView extends StatelessWidget {
  const CredentialsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CredentialsForm(),
        ),
      ),
    );
  }
}
