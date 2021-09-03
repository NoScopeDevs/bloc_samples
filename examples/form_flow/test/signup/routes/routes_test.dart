import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:form_flow/signup/signup.dart';
import 'package:profile/profile.dart';

void main() {
  group('onGenerateSignUpPages', () {
    test(
      'returns [CredentialsPage] when SignUpState has empty name and email',
      () {
        expect(
          onGenerateSignUpPages(const SignUpState(), []),
          [
            isA<MaterialPage>().having(
              (p) => p.child,
              'child',
              isA<CredentialsPage>(),
            )
          ],
        );
      },
    );

    test('returns [BiographyPage] when AppUnauthenticated', () {
      expect(
        onGenerateSignUpPages(
          const SignUpState(
            user: User(
              name: 'Marcos',
              email: 'marcos@noscope.dev',
              biography: '',
              pin: '',
            ),
          ),
          [],
        ),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<BiographyPage>(),
          )
        ],
      );
    });

    test('returns [SignUpPage] when AppUnauthenticated', () {
      expect(
        onGenerateSignUpPages(
          const SignUpState(
            user: User(
              name: 'Marcos',
              email: 'marcos@noscope.dev',
              biography: 'Engineer',
              pin: '',
            ),
          ),
          [],
        ),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<PinPage>(),
          )
        ],
      );
    });
  });
}
