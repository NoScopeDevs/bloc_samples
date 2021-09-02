import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/app/app.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppEvent', () {
    final user = MockUser();
    group('AppSignUpCompleted', () {
      test('supports value comparison', () {
        expect(
          AppSignUpCompleted(user),
          AppSignUpCompleted(user),
        );
      });
    });

    group('AppLogoutRequested', () {
      test('supports value comparison', () {
        expect(
          AppLogoutRequested(),
          AppLogoutRequested(),
        );
      });
    });
  });
}
