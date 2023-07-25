import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';

class CredentialsPage extends StatelessWidget {
  const CredentialsPage({super.key});

  static Page<void> page() {
    return const MaterialPage<void>(
      child: CredentialsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CredentialsCubit(),
      child: const CredentialsView(),
    );
  }
}

class CredentialsView extends StatelessWidget {
  const CredentialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CredentialsForm(),
        ),
      ),
      floatingActionButton: _SubmitButton(),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<CredentialsCubit, CredentialsState>(
      builder: (context, state) {
        if (!state.isValid || state.isPure) return const SizedBox.shrink();

        return FloatingActionButton.extended(
          key: const Key('credentialsPage_submitButton_floatingActionButton'),
          onPressed: () {
            final event = SignUpCredentialsSubmitted(
              email: state.email.value,
              name: state.name.value,
            );
            context.read<SignUpBloc>().add(event);
          },
          label: Text(l10n.nextButtonText),
        );
      },
    );
  }
}
