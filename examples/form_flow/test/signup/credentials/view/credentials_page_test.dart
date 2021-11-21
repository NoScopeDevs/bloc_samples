import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('CredentialsPage', () {
    const email = EmailFormInput.dirty('marcos@noscope.dev');
    const name = NameFormInput.dirty('marcos');

    group('SubmitButton', () {
      const submitButtonKey =
          Key('credentialsPage_submitButton_floatingActionButton');

      testWidgets(
        'adds SignUpCredentialsSubmitted when pressing FloatingActionButton',
        (tester) async {
          final credentialsCubit = MockCredentialsCubit();
          final signUpBloc = MockSignUpBloc();
          when(() => credentialsCubit.state).thenReturn(
            const CredentialsState(
              email: email,
              name: name,
              status: FormzStatus.valid,
            ),
          );

          await tester.pumpApp(
            MultiBlocProvider(
              providers: [
                BlocProvider<CredentialsCubit>.value(value: credentialsCubit),
                BlocProvider<SignUpBloc>.value(value: signUpBloc),
              ],
              child: const CredentialsView(),
            ),
          );
          await tester.ensureVisible(find.byKey(submitButtonKey));
          await tester.tap(find.byKey(submitButtonKey));

          verify(
            () => signUpBloc.add(
              SignUpCredentialsSubmitted(
                email: email.value,
                name: name.value,
              ),
            ),
          ).called(1);
        },
      );
    });
  });
}
