import 'package:formz/formz.dart';

/// Validation error for Pin [FormzInput]
enum PinValidationError {
  /// Pin is invalid (generic validation error)
  invalid
}

/// {@template pin_form_input}
/// Pin form input.
/// {@endtemplate}
class PinFormInput extends FormzInput<String, PinValidationError> {
  /// {@macro pin_form_input}
  const PinFormInput.pure() : super.pure('');

  /// {@macro pin_form_input}
  const PinFormInput.dirty([super.value = '']) : super.dirty();

  /// {@template max_length}
  /// Maximum length the pin requires to be valid.
  /// {@endtemplate}
  static int get maxLength {
    if (_maxLength == null) {
      assert(
        () {
          _maxLength = 4;
          return true;
        }(),
        'Pin’s maximum length defaults to 4.',
      );
    }
    return _maxLength ??= 4;
  }

  /// {@macro max_length}
  static set maxLength(int value) => _maxLength = value;

  static int? _maxLength;

  @override
  PinValidationError? validator(String value) {
    if (value.isEmpty || value.length != maxLength) {
      return PinValidationError.invalid;
    }
    return null;
  }
}
