import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:preference_navigation/home/home.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    test('is routable', () {
      expect(HomePage.route(), isA<MaterialPageRoute<void>>());
    });

    testWidgets('renders HomePage', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        const HomePage(),
        preferencesBloc: preferencesBloc,
      );
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets(
      'adds PreferencesCleared when IconButton is pressed',
      (tester) async {
        final preferencesBloc = MockPreferencesBloc();
        when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

        await tester.pumpApp(
          const HomeView(),
          preferencesBloc: preferencesBloc,
        );
        await tester.tap(find.byType(IconButton));
        verify(() => preferencesBloc.add(PreferencesCleared()));
      },
    );

    testWidgets(
      'navigates when PreferencesEmpty is emitted',
      (tester) async {
        final navigator = MockNavigator();
        when(() => navigator.push<void>(any())).thenAnswer((_) async {});

        final preferencesBloc = MockPreferencesBloc();
        whenListen(
          preferencesBloc,
          Stream.fromIterable([const PreferencesEmpty()]),
          initialState: const PreferencesInitial(),
        );

        await tester.pumpApp(
          MockNavigatorProvider(
            navigator: navigator,
            child: const HomeView(),
          ),
          preferencesBloc: preferencesBloc,
        );
        verify(
          () => navigator.push<void>(any(that: isRoute<void>())),
        ).called(1);
      },
    );

    testWidgets(
      'renders PreferencesList when state is PreferencesLoaded',
      (tester) async {
        final preferencesBloc = MockPreferencesBloc();
        when(() => preferencesBloc.state).thenReturn(
          const PreferencesLoaded(<String, dynamic>{'key': 'value'}),
        );

        await tester.pumpApp(
          const HomeView(),
          preferencesBloc: preferencesBloc,
        );
        expect(find.byType(PreferencesList), findsOneWidget);
      },
    );
  });
}
