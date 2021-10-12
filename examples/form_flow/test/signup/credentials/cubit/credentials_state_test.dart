// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';

void main() {
  const email = EmailFormInput.dirty('verde@noscope.dev');
  const name = NameFormInput.dirty('Verde');

  group('CredentialsState', () {
    test('supports value comparisons', () {
      expect(CredentialsState(), CredentialsState());
    });

    test('returns same object when no properties are passed', () {
      expect(CredentialsState().copyWith(), CredentialsState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        CredentialsState().copyWith(email: email, name: name),
        CredentialsState(email: email, name: name),
      );
    });
  });
}
