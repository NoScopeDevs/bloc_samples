// ignore_for_file: prefer_const_constructors
import 'package:formz_inputs/formz_inputs.dart';
import 'package:test/test.dart';

void main() {
  const pinString = '0123';

  group('PinFormInput', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final pin = PinFormInput.pure();
        expect(pin.value, '');
        expect(pin.pure, true);
      });

      test('dirty creates correct instance', () {
        final pin = PinFormInput.dirty(pinString);
        expect(pin.value, pinString);
        expect(pin.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when pin is empty', () {
        expect(
          PinFormInput.dirty().error,
          PinValidationError.invalid,
        );
      });

      test(
        'returns too long error when pin is longer than default 4 chars',
        () {
          expect(
            PinFormInput.dirty('${pinString}4').error,
            PinValidationError.invalid,
          );
        },
      );

      test('is valid when pin is valid', () {
        expect(
          PinFormInput.dirty(pinString).error,
          isNull,
        );
      });
    });

    group('maxLength', () {
      test('sets new value correctly', () {
        const newMaxLength = 6;
        PinFormInput.maxLength = newMaxLength;
        expect(PinFormInput.maxLength, newMaxLength);
      });
    });
  });
}
