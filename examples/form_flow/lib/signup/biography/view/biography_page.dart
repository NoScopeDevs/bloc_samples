import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

class BiographyPage extends StatelessWidget {
  const BiographyPage({super.key});

  static Page page() => const MaterialPage<void>(child: BiographyPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiographyCubit(),
      child: const BiographyView(),
    );
  }
}

class BiographyView extends StatelessWidget {
  const BiographyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: _BiographyInput(),
        ),
      ),
      floatingActionButton: _SubmitButton(),
    );
  }
}

class _BiographyInput extends StatelessWidget {
  const _BiographyInput();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<BiographyCubit, BiographyState, BiographyFormInput>(
      selector: (state) => state.biography,
      builder: (context, state) {
        return TextField(
          key: const Key('biographyView_biographyInput_textField'),
          autocorrect: false,
          onChanged: (biography) {
            context.read<BiographyCubit>().changeBiography(biography);
          },
          decoration: InputDecoration(
            labelText: l10n.biographyInputLabelText,
            errorText: () {
              if (state.invalid) {
                if (state.error == BiographyValidationError.empty) {
                  return l10n.emptyBiographyInputErrorText;
                } else if (state.error == BiographyValidationError.tooLong) {
                  return l10n.longBiographyInputErrorText;
                }
                return null;
              }
            }(),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<BiographyCubit, BiographyState>(
      builder: (context, state) {
        if (state.status.isInvalid || state.status.isPure) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton.extended(
          key: const Key('biographyPage_submitButton_floatingActionButton'),
          onPressed: () {
            final event = SignUpBiographySubmitted(state.biography.value);
            context.read<SignUpBloc>().add(event);
          },
          label: Text(l10n.nextButtonText),
        );
      },
    );
  }
}
