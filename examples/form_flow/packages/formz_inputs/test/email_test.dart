// ignore_for_file: prefer_const_constructors

import 'package:formz_inputs/formz_inputs.dart';
import 'package:test/test.dart';

void main() {
  const emailString = 'marcos@noscope.dev';
  group('EmailFormInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final email = EmailFormInput.pure();
        expect(email.value, '');
        expect(email.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        final email = EmailFormInput.dirty(emailString);
        expect(email.value, emailString);
        expect(email.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when email is empty', () {
        expect(
          EmailFormInput.dirty().error,
          EmailValidationError.invalid,
        );
      });

      test('returns invalid error when email is malformed', () {
        expect(
          EmailFormInput.dirty('test').error,
          EmailValidationError.invalid,
        );
      });

      test('is valid when email is valid', () {
        expect(
          EmailFormInput.dirty(emailString).error,
          isNull,
        );
      });
    });
  });
}
