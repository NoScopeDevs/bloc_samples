import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

class CredentialsPage extends StatelessWidget {
  const CredentialsPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CredentialsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CredentialsCubit(),
      child: const CredentialsForm(),
    );
  }
}

class CredentialsForm extends StatelessWidget {
  const CredentialsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _EmailInput(),
              _NameInput(),
              _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<CredentialsCubit, CredentialsState, EmailFormInput>(
      selector: (state) => state.email,
      builder: (context, state) {
        return TextField(
          autocorrect: false,
          onChanged: (email) {
            context.read<CredentialsCubit>().changeEmail(email);
          },
          decoration: InputDecoration(
            labelText: l10n.emailInputLabelText,
            errorText: state.invalid ? l10n.invalidEmailInputErrorText : null,
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<CredentialsCubit, CredentialsState, NameFormInput>(
      selector: (state) => state.name,
      builder: (context, state) {
        return TextField(
          autocorrect: false,
          onChanged: (name) {
            context.read<CredentialsCubit>().changeName(name);
          },
          decoration: InputDecoration(
            labelText: l10n.nameInputLabelText,
            errorText: state.invalid ? l10n.shortNameInputErrorText : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<CredentialsCubit, CredentialsState>(
      builder: (context, state) {
        if (state.status.isInvalid || state.status.isPure) {
          return const SizedBox.shrink();
        }

        return TextButton(
          onPressed: () {
            final event = SignUpCredentialsSubmitted(
              email: state.email.value,
              name: state.name.value,
            );
            context.read<SignUpBloc>().add(event);
            context.flow<SignUpState>().update(
                  (_) => context.read<SignUpBloc>().state,
                );
          },
          child: Text(l10n.nextButtonText),
        );
      },
    );
  }
}
