import 'package:flutter/widgets.dart';

import 'package:form_flow/signup/signup.dart';

List<Page> onGenerateSignUpPages(SignUpState state, List<Page> pages) {
  if (state.profile.email.isEmpty && state.profile.name.isEmpty) {
    debugPrint('to CredentialsPage!');
    return [CredentialsPage.page()];
  } else if (state.profile.biography.isEmpty) {
    return [BiographyPage.page()];
  } else if (state.profile.pin.isEmpty) {
    return [PinPage.page()];
  } else {
    return [CredentialsPage.page()];
  }
}
