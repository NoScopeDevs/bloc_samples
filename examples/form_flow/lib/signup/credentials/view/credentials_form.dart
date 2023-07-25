import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

class CredentialsForm extends StatelessWidget {
  const CredentialsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _EmailInput(),
        _NameInput(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<CredentialsCubit, CredentialsState, EmailFormInput>(
      selector: (state) => state.email,
      builder: (context, state) {
        return TextField(
          key: const Key('credentialsForm_emailInput_textField'),
          autocorrect: false,
          onChanged: context.read<CredentialsCubit>().changeEmail,
          decoration: InputDecoration(
            labelText: l10n.emailInputLabelText,
            errorText: switch (state.error) {
              EmailValidationError.invalid => l10n.invalidEmailInputErrorText,
              null => null,
            },
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<CredentialsCubit, CredentialsState, NameFormInput>(
      selector: (state) => state.name,
      builder: (context, state) {
        return TextField(
          key: const Key('credentialsForm_nameInput_textField'),
          autocorrect: false,
          textCapitalization: TextCapitalization.words,
          onChanged: context.read<CredentialsCubit>().changeName,
          decoration: InputDecoration(
            labelText: l10n.nameInputLabelText,
            errorText: switch (state.error) {
              NameValidationError.tooShort => l10n.shortNameInputErrorText,
              null => null,
            },
          ),
        );
      },
    );
  }
}
