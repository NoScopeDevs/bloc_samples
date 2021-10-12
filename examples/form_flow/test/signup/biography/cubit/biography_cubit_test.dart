import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  group('BiographyCubit', () {
    blocTest<BiographyCubit, BiographyState>(
      'emits state with new biography when changeBiography is called.',
      build: () => BiographyCubit(),
      act: (bloc) => bloc.changeBiography('value'),
      expect: () => const <BiographyState>[
        BiographyState(
          biography: BiographyFormInput.dirty('value'),
          status: FormzStatus.valid,
        ),
      ],
    );
  });
}
