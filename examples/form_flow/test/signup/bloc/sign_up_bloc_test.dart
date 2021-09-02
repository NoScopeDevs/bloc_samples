import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:profile/profile.dart';

void main() {
  const email = 'marcos@noscope.dev';
  const name = 'Marcos';
  const biography = "I'm a software engineer";
  const pin = '0123';

  group('SignUpBloc', () {
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] with [email, name] '
      'when SignUpCredentialsSubmitted is added.',
      build: () => SignUpBloc(),
      act: (bloc) {
        bloc.add(const SignUpCredentialsSubmitted(email: email, name: name));
      },
      expect: () => const <SignUpState>[
        SignUpState(
          user: User(email: email, name: name, biography: '', pin: ''),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] with [email, name, biography] '
      'when SignUpBiographySubmitted is added.',
      build: () => SignUpBloc(),
      seed: () => const SignUpState(
        user: User(email: email, name: name, biography: '', pin: ''),
      ),
      act: (bloc) => bloc.add(const SignUpBiographySubmitted(biography)),
      expect: () => const <SignUpState>[
        SignUpState(
          user: User(email: email, name: name, biography: biography, pin: ''),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] with [email, name, biography, pin] '
      'and complete: true when SignUpBiographySubmitted is added.',
      build: () => SignUpBloc(),
      seed: () => const SignUpState(
        user: User(email: email, name: name, biography: biography, pin: ''),
      ),
      act: (bloc) => bloc.add(const SignUpPinSubmitted(pin)),
      expect: () => const <SignUpState>[
        SignUpState(
          user: User(email: email, name: name, biography: biography, pin: pin),
          complete: true,
        ),
      ],
    );
  });
}
