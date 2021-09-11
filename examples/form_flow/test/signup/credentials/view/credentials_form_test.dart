import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  setUpAll(registerFallbackValues);

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
    });
  });
}
