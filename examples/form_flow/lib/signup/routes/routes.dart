import 'package:flutter/widgets.dart';

import 'package:form_flow/signup/signup.dart';

List<Page> onGenerateSignUpPages(SignUpState state, List<Page> pages) {
  if (state.email.invalid && state.name.invalid) {
    return [CredentialsForm.page()];
  } else if (state.biography.invalid) {
    return [BiographyInput.page()];
  } else if (state.pin.invalid) {
    return [PinInput.page()];
  } else {
    return [];
  }
}
