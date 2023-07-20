import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  group('PinCubit', () {
    blocTest<PinCubit, PinState>(
      'emits state with new biography when changeBiography is called.',
      build: PinCubit.new,
      act: (bloc) => bloc.changePin('02'),
      expect: () => const <PinState>[
        PinState(
          pin: PinFormInput.dirty('02'),
        ),
      ],
    );
  });
}
