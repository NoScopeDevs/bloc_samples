import 'package:formz/formz.dart';

/// Validation error for Email [FormzInput]
enum EmailValidationError {
  /// Email is invalid (generic validation error)
  invalid
}

/// {@template email_form_input}
/// Email form input.
/// {@endtemplate}
class EmailFormInput extends FormzInput<String, EmailValidationError> {
  /// {@macro email_form_input}
  const EmailFormInput.pure() : super.pure('');

  /// {@macro email_form_input}
  const EmailFormInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
