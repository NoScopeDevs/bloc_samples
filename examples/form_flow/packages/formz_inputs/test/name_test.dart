// ignore_for_file: prefer_const_constructors

import 'package:formz_inputs/formz_inputs.dart';
import 'package:test/test.dart';

void main() {
  const nameString = 'Marcos';
  group('NameFormInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final name = NameFormInput.pure();
        expect(name.value, '');
        expect(name.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        final name = NameFormInput.dirty(nameString);
        expect(name.value, nameString);
        expect(name.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns too short error when name is empty', () {
        expect(
          NameFormInput.dirty().error,
          NameValidationError.tooShort,
        );
      });

      test('returns too short error when name length is shorter than 2', () {
        expect(
          NameFormInput.dirty(nameString[0]).error,
          NameValidationError.tooShort,
        );
      });

      test('is valid when name is valid', () {
        expect(
          NameFormInput.dirty(nameString).error,
          isNull,
        );
      });
    });
  });
}
