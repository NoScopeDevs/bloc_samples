import 'package:formz/formz.dart';

/// Validation error for Name [FormzInput]
enum NameValidationError {
  /// Name is too short (generic validation error)
  tooShort,
}

/// {@template name_form_input}
/// Name form input.
/// {@endtemplate}
class NameFormInput extends FormzInput<String, NameValidationError> {
  /// {@macro name_form_input}
  const NameFormInput.pure() : super.pure('');

  /// {@macro name_form_input}
  const NameFormInput.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty || value.length < 2) return NameValidationError.tooShort;
  }
}
