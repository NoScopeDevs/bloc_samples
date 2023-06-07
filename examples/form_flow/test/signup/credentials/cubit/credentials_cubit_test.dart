import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  const email = 'elian@noscope.dev';
  const name = 'Elian';

  group('CredentialsCubit', () {
    blocTest<CredentialsCubit, CredentialsState>(
      'emits state with new email when changeEmail is called.',
      build: CredentialsCubit.new,
      act: (bloc) => bloc.changeEmail(email),
      expect: () => const <CredentialsState>[
        CredentialsState(
          email: EmailFormInput.dirty(email),
        ),
      ],
    );

    blocTest<CredentialsCubit, CredentialsState>(
      'emits state with new name when changeName is called.',
      build: CredentialsCubit.new,
      act: (bloc) => bloc.changeName(name),
      expect: () => const <CredentialsState>[
        CredentialsState(
          name: NameFormInput.dirty(name),
        ),
      ],
    );
  });
}
