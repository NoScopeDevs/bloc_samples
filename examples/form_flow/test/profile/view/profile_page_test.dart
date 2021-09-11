import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/profile/profile.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(registerFallbackValues);

  group('ProfilePage', () {
    final user = MockUser();

    setUp(() {
      when(() => user.email).thenReturn('email');
      when(() => user.name).thenReturn('name');
      when(() => user.biography).thenReturn('biography');
    });

    testWidgets(
      'renders props of given user',
      (tester) async {
        await tester.pumpApp(ProfilePage(user: user));
        expect(find.text('email'), findsOneWidget);
        expect(find.text('name'), findsOneWidget);
        expect(find.text('biography'), findsOneWidget);
      },
    );

    testWidgets(
      'adds AppLogoutRequested when pressing IconButton',
      (tester) async {
        final appBloc = MockAppBloc();
        await tester.pumpApp(
          ProfilePage(user: user),
          appBloc: appBloc,
        );
        await tester.tap(find.byType(IconButton));
        verify(() => appBloc.add(AppLogoutRequested()));
      },
    );
  });
}
