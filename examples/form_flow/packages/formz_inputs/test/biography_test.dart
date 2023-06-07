// ignore_for_file: prefer_const_constructors

import 'package:formz_inputs/formz_inputs.dart';
import 'package:test/test.dart';

void main() {
  final biographyString = String.fromCharCodes(
    Iterable.generate(140, (_) => 1),
  );

  group('BiographyFormInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final biography = BiographyFormInput.pure();
        expect(biography.value, '');
        expect(biography.isPure, true);
      });

      test('dirty creates correct instance', () {
        final biography = BiographyFormInput.dirty(biographyString);
        expect(biography.value, biographyString);
        expect(biography.isPure, false);
      });
    });

    group('validator', () {
      test('returns empty error when biography is empty', () {
        expect(
          BiographyFormInput.dirty().error,
          BiographyValidationError.empty,
        );
      });

      test(
        'returns too long error when biography is longer than 140 chars',
        () {
          expect(
            BiographyFormInput.dirty('$biographyString a').error,
            BiographyValidationError.tooLong,
          );
        },
      );

      test('is valid when biography is valid', () {
        expect(
          BiographyFormInput.dirty(biographyString).error,
          isNull,
        );
      });
    });
  });
}
