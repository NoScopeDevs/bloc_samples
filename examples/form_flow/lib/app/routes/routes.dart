import 'package:flutter/widgets.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/profile/profile.dart';
import 'package:form_flow/signup/signup.dart';

List<Page> onGenerateAppViewPages(AppState state, List<Page> pages) {
  if (state is AppAuthenticated) {
    return [ProfilePage.page()];
  } else if (state is AppUnauthenticated) {
    return [SignUpPage.page()];
  } else {
    return [SignUpPage.page()];
  }
}
