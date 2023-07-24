import 'package:flutter/widgets.dart';
import 'package:form_flow/signup/signup.dart';

List<Page<void>> onGenerateSignUpPages(
  SignUpState state,
  List<Page<void>> pages,
) {
  return switch (state) {
    SignUpState(user: final user) when user.email.isEmpty && user.pin.isEmpty =>
      [CredentialsPage.page()],
    SignUpState(user: final user) when user.biography.isEmpty => [
        BiographyPage.page()
      ],
    _ => [PinPage.page()],
  };
}
