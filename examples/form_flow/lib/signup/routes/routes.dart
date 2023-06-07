import 'package:flutter/widgets.dart';
import 'package:form_flow/signup/signup.dart';

List<Page<void>> onGenerateSignUpPages(
  SignUpState state,
  List<Page<void>> pages,
) {
  if (state.user.email.isEmpty && state.user.name.isEmpty) {
    return [CredentialsPage.page()];
  } else if (state.user.biography.isEmpty) {
    return [BiographyPage.page()];
  } else {
    return [PinPage.page()];
  }
}
