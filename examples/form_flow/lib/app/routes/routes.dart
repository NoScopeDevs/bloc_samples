import 'package:flutter/widgets.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/profile/profile.dart';
import 'package:form_flow/signup/signup.dart';

List<Page<void>> onGenerateAppViewPages(
  AppState state,
  List<Page<void>> page,
) {
  if (state is AppAuthenticated) {
    return [ProfilePage.page(state.user)];
  } else {
    return [SignUpPage.page()];
  }
}
