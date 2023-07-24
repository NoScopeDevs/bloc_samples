import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

class PinPage extends StatelessWidget {
  const PinPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PinPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PinCubit(),
      child: const PinView(),
    );
  }
}

class PinView extends StatelessWidget {
  const PinView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: _PinInput(),
        ),
      ),
      floatingActionButton: _SubmitButton(),
    );
  }
}

class _PinInput extends StatelessWidget {
  const _PinInput();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<PinCubit, PinState, PinFormInput>(
      selector: (state) => state.pin,
      builder: (context, state) {
        return TextField(
          key: const Key('pinView_pinInput_textField'),
          autocorrect: false,
          obscureText: true,
          onChanged: context.read<PinCubit>().changePin,
          inputFormatters: [
            LengthLimitingTextInputFormatter(PinFormInput.maxLength),
          ],
          decoration: InputDecoration(
            labelText: l10n.pinInputLabelText,
            errorText: switch (state.error) {
              PinValidationError.invalid => l10n.invalidPinInputErrorText,
              null => null
            },
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
    return BlocBuilder<PinCubit, PinState>(
      builder: (context, state) {
        if (state.pin.isNotValid || state.pin.isPure) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton.extended(
          key: const Key('pinPage_submitButton_floatingActionButton'),
          onPressed: () {
            final event = SignUpPinSubmitted(state.pin.value);
            context.read<SignUpBloc>().add(event);
          },
          label: Text(l10n.completeButtonText),
        );
      },
    );
  }
}
