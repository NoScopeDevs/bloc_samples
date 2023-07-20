import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('CredentialsForm', () {
    group('EmailInput', () {
      const emailInputKey = Key('credentialsForm_emailInput_textField');

      testWidgets(
        'calls changeEmail when email input changes',
        (tester) async {
          final credentialsCubit = MockCredentialsCubit();
          when(() => credentialsCubit.state)
              .thenReturn(const CredentialsState());

          await tester.pumpApp(
            BlocProvider<CredentialsCubit>.value(
              value: credentialsCubit,
              child: const CredentialsForm(),
            ),
          );
          await tester.enterText(find.byKey(emailInputKey), 'M');

          verify(() => credentialsCubit.changeEmail(any())).called(1);
        },
      );

      testWidgets(
        'renders TextField with invalidEmailInputErrorText '
        'when error is EmailValidationError.invalid',
        (tester) async {
          final credentialsCubit = MockCredentialsCubit();
          when(() => credentialsCubit.state).thenReturn(
            const CredentialsState(
              email: EmailFormInput.dirty('@'),
            ),
          );

          await tester.pumpApp(
            BlocProvider<CredentialsCubit>.value(
              value: credentialsCubit,
              child: const CredentialsForm(),
            ),
          );

          final inputFinder = find.byKey(emailInputKey);
          final textField = tester.widget<TextField>(inputFinder);
          final context = tester.element(inputFinder);

          expect(
            textField.decoration!.errorText,
            context.l10n.invalidEmailInputErrorText,
          );
        },
      );
    });

    group('NameInput', () {
      const nameInputKey = Key('credentialsForm_nameInput_textField');

      testWidgets(
        'calls changeName when name input changes',
        (tester) async {
          final credentialsCubit = MockCredentialsCubit();
          when(() => credentialsCubit.state)
              .thenReturn(const CredentialsState());

          await tester.pumpApp(
            BlocProvider<CredentialsCubit>.value(
              value: credentialsCubit,
              child: const CredentialsForm(),
            ),
          );
          await tester.enterText(find.byKey(nameInputKey), 'M');

          verify(() => credentialsCubit.changeName(any())).called(1);
        },
      );

      testWidgets(
        'renders TextField with shortNameInputErrorText '
        'when error is NameValidationError.tooShort',
        (tester) async {
          final credentialsCubit = MockCredentialsCubit();
          when(() => credentialsCubit.state).thenReturn(
            const CredentialsState(
              name: NameFormInput.dirty('a'),
            ),
          );

          await tester.pumpApp(
            BlocProvider<CredentialsCubit>.value(
              value: credentialsCubit,
              child: const CredentialsForm(),
            ),
          );

          final inputFinder = find.byKey(nameInputKey);
          final textField = tester.widget<TextField>(inputFinder);
          final context = tester.element(inputFinder);

          expect(
            textField.decoration!.errorText,
            context.l10n.shortNameInputErrorText,
          );
        },
      );
    });
  });
}
