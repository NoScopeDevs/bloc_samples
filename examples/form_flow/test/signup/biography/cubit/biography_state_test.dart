// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  group('BiographyState', () {
    test('supports value comparisons', () {
      expect(BiographyState(), BiographyState());
    });

    test('returns same object when no properties are passed', () {
      expect(BiographyState().copyWith(), BiographyState());
    });

    test('returns object with updated biography when biography is passed', () {
      expect(
        BiographyState().copyWith(biography: BiographyFormInput.dirty('value')),
        BiographyState(biography: BiographyFormInput.dirty('value')),
      );
    });
  });
}
