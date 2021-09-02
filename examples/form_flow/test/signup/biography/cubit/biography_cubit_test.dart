import 'package:bloc_test/bloc_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  blocTest<BiographyCubit, BiographyState>(
    'emits [MyState] when MyEvent is added.',
    build: () => BiographyCubit(),
    act: (bloc) => bloc.changeBiography('value'),
    expect: () => const <BiographyState>[
      BiographyState(
        biography: BiographyFormInput.dirty('value'),
        status: FormzStatus.valid,
      )
    ],
  );
}
