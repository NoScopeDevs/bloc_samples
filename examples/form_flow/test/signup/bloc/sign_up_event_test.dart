// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';

void main() {
  const email = 'marcos@noscope.dev';
  const name = 'Marcos';
  const biography = "I'm a software engineer";
  const pin = '0123';

  group('SignUpEvent', () {
    group('SignUpCredentialsSubmitted', () {
      test('supports value comparison', () {
        expect(
          SignUpCredentialsSubmitted(email: email, name: name),
          SignUpCredentialsSubmitted(email: email, name: name),
        );
      });
    });

    group('SignUpBiographySubmitted', () {
      test('supports value comparison', () {
        expect(
          SignUpBiographySubmitted(biography),
          SignUpBiographySubmitted(biography),
        );
      });
    });

    group('SignUpPinSubmitted', () {
      test('supports value comparison', () {
        expect(
          SignUpPinSubmitted(pin),
          SignUpPinSubmitted(pin),
        );
      });
    });
  });
}
