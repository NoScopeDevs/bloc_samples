import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/profile/profile.dart';
import 'package:form_flow/signup/signup.dart';

import '../../helpers/helpers.dart';

void main() {
  group('onGenerateAppViewPages', () {
    test('returns [ProfilePage] when AppAuthenticated', () {
      expect(
        onGenerateAppViewPages(AppAuthenticated(MockUser()), []),
        [
          isA<MaterialPage<void>>().having(
            (p) => p.child,
            'child',
            isA<ProfilePage>(),
          )
        ],
      );
    });

    test('returns [SignUpPage] when AppUnauthenticated', () {
      expect(
        onGenerateAppViewPages(AppUnauthenticated(), []),
        [
          isA<MaterialPage<void>>().having(
            (p) => p.child,
            'child',
            isA<SignUpPage>(),
          )
        ],
      );
    });
  });
}
