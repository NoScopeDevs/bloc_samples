import 'package:formz/formz.dart';

/// Validation error for Biography [FormzInput]
enum BiographyValidationError {
  /// Biography is empty
  empty,

  /// Biography is too long
  tooLong,
}

/// {@template biography_form_input}
/// Biography form input.
/// {@endtemplate}
class BiographyFormInput extends FormzInput<String, BiographyValidationError> {
  /// {@macro biography_form_input}
  const BiographyFormInput.pure() : super.pure('');

  /// {@macro biography_form_input}
  const BiographyFormInput.dirty([super.value = '']) : super.dirty();

  @override
  BiographyValidationError? validator(String value) {
    if (value.isEmpty) return BiographyValidationError.empty;
    if (value.length > 140) return BiographyValidationError.tooLong;
    return null;
  }
}
