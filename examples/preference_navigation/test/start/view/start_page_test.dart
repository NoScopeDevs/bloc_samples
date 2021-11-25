import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preference_navigation/start/start.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('StartPage', () {
    testWidgets('renders StartView', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        const StartPage(),
        preferencesBloc: preferencesBloc,
      );
      expect(find.byType(StartView), findsOneWidget);
    });
  });

  group('StartView', () {
    testWidgets(
      'replaces route when PreferencesLoaded is emitted',
      (tester) async {
        final navigator = MockNavigator();
        when(() => navigator.pushReplacement(any())).thenAnswer((_) async {});

        final preferencesBloc = MockPreferencesBloc();
        whenListen(
          preferencesBloc,
          Stream.fromIterable(const [
            PreferencesLoaded(<String, dynamic>{'key': 'value'}),
          ]),
          initialState: const PreferencesInitial(),
        );

        await tester.pumpApp(
          MockNavigatorProvider(
            navigator: navigator,
            child: const StartView(),
          ),
          preferencesBloc: preferencesBloc,
        );
        verify(
          () => navigator.pushReplacement(any(that: isRoute<void>())),
        ).called(1);
      },
    );

    testWidgets(
      'renders NoPreferences when state is PreferencesEmpty',
      (tester) async {
        final preferencesBloc = MockPreferencesBloc();
        when(() => preferencesBloc.state).thenReturn(const PreferencesEmpty());

        await tester.pumpApp(
          const StartView(),
          preferencesBloc: preferencesBloc,
        );
        expect(find.byType(NoPreferences), findsOneWidget);
      },
    );
  });

  group('NoPreferences', () {
    const noPreferencesGoButtonKey = Key('noPreferences_go_textButton');

    testWidgets(
      'navigates to PreferencesPage when TextButton is tapped',
      (tester) async {
        final navigator = MockNavigator();
        when(() => navigator.push(any())).thenAnswer((_) async {});

        await tester.pumpApp(
          MockNavigatorProvider(
            navigator: navigator,
            child: const NoPreferences(),
          ),
        );
        await tester.ensureVisible(find.byKey(noPreferencesGoButtonKey));
        await tester.tap(find.byKey(noPreferencesGoButtonKey));

        verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
      },
    );
  });
}
