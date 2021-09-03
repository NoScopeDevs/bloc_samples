// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  group('PinState', () {
    test('supports value comparisons', () {
      expect(PinState(), PinState());
    });

    test('returns same object when no properties are passed', () {
      expect(PinState().copyWith(), PinState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        PinState().copyWith(status: FormzStatus.pure),
        PinState(),
      );
    });

    test('returns object with updated biography when biography is passed', () {
      expect(
        PinState().copyWith(pin: PinFormInput.dirty('012')),
        PinState(pin: PinFormInput.dirty('012')),
      );
    });
  });
}
