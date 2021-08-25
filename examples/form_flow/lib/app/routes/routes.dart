import 'package:flutter/widgets.dart';
import 'package:form_flow/authentication/authentication.dart';
import 'package:form_flow/info/info.dart';

List<Page> onGenerateAppViewPages(AuthenticationState state, List<Page> pages) {
  switch (state) {
    case AuthenticationState.unauthenticated:
      return [FormPage.page()];
    case AuthenticationState.authenticated:
      return [InfoPage.page()];
  }
}
