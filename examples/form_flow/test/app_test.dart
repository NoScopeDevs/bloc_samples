// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/signup/view/view.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets(
      'renders SignUpPage when app state is unauthenticated',
      (tester) async {
        final appBloc = MockAppBloc();
        when(() => appBloc.state).thenReturn(AppUnauthenticated());
        await tester.pumpApp(const App());
        expect(find.byType(SignUpPage), findsOneWidget);
      },
    );
  });
}
