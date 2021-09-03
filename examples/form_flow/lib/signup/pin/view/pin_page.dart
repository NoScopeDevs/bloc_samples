import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: PinPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PinCubit(),
      child: const PinView(),
    );
  }
}

class PinView extends StatelessWidget {
  const PinView({Key? key}) : super(key: key);

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
  const _PinInput({Key? key}) : super(key: key);

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
          onChanged: (pin) => context.read<PinCubit>().changePin(pin),
          decoration: InputDecoration(
            labelText: l10n.pinInputLabelText,
            errorText: state.invalid ? l10n.invalidPinInputErrorText : null,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(PinFormInput.maxLength),
          ],
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
    return BlocBuilder<PinCubit, PinState>(
      builder: (context, state) {
        if (state.status.isInvalid || state.status.isPure) {
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
