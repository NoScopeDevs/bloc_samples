import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

class CredentialsForm extends StatelessWidget {
  const CredentialsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _EmailInput(),
        _NameInput(),
      ],
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
          textCapitalization: TextCapitalization.words,
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
