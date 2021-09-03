// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/signup/signup.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SignUpState', () {
    test('supports value comparisons', () {
      expect(SignUpState(), SignUpState());
    });

    test('returns same object when no properties are passed', () {
      expect(SignUpState().copyWith(), SignUpState());
    });

    test('returns object with updated status when status is passed', () {
      final user = MockUser();
      expect(
        SignUpState().copyWith(user: user),
        SignUpState(user: user),
      );
    });
  });
}
